import { Boom } from "@hapi/boom";
import { ErrorRequestHandler } from "express";
import { logger } from "../config";
import {
  PrismaClientValidationError,
  PrismaClientKnownRequestError,
  PrismaClientInitializationError,
  PrismaClientUnknownRequestError,
  PrismaClientRustPanicError,
} from "@prisma/client/runtime/library";

/**
 * Middleware para loggear los errores
 * @param err objeto de error
 * @param req requesst
 * @param res response
 * @param next siguiente handler
 */
const logErrores: ErrorRequestHandler = (err: Error, req, res, next) => {
  logger.error(err);
  next(err);
};

/**
 * Middleware para atrapar los errores de boom (manejados por el servidor)
 */
const boomErrorHandler: ErrorRequestHandler = (err: Error, req, res, next) => {
  if (err instanceof Boom) {
    const { output } = err;
    return res.status(output.statusCode).json(output.payload);
  } else {
    next(err);
  }
};

/**
 * Middleware para atrapar los errores de prisma
 */
const prismaClientValidationErrorHandler: ErrorRequestHandler = (
  err: Error,
  req,
  res,
  next
) => {
  if (err instanceof PrismaClientValidationError) {
    const { name, message } = err;
    return res
      .status(400)
      .json({ errorType: "¡Error de validación con prisma!", name, message });
  } else if (err instanceof PrismaClientKnownRequestError) {
    const { code, message } = err;
    return res
      .status(400)
      .json({ errorType: "¡Error de request con prisma!", code, message });
  } else if (err instanceof PrismaClientInitializationError) {
    const { name, message } = err;
    return res
      .status(400)
      .json({ errorType: "¡Error de iniciación con prisma!", name, message });
  } else if (err instanceof PrismaClientRustPanicError) {
    const { name, message } = err;
    return res
      .status(400)
      .json({ errorType: "¡Error de rust panic con prisma!", name, message });
  } else if (err instanceof PrismaClientUnknownRequestError) {
    const { name, message } = err;
    return res.status(400).json({
      errorType: "¡Error de request desconocido con prisma!",
      name,
      message,
    });
  } else {
    next(err);
  }
};

/**
 * MIddleware para atrapar los errores del servidor
 */
const genericErrorHandler: ErrorRequestHandler = (
  err: Error,
  req,
  res,
  next
) => {
  return res.status(500).json({
    message: err.message,
    stack: err.stack,
  });
};

export {
  logErrores,
  genericErrorHandler,
  prismaClientValidationErrorHandler,
  boomErrorHandler,
};
