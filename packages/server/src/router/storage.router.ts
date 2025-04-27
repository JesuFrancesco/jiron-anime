import { Router } from "express";
import multer from "multer";
import { StorageService } from "../service/storage.service";
import { authHandler } from "../middleware/authorization.handler";

const storage = multer.memoryStorage();
const upload = multer({ storage });

const storageRouter = Router();
const storeService = new StorageService();

storageRouter.use(authHandler);

storageRouter.post(`/single`, upload.single("file"), async (req, res, next) => {
  try {
    const uploadResult = await storeService.uploadSingleFile(req.file);

    return res.status(200).json({
      message: "¡El archivo fue guardado de manera exitosa!",
      file: uploadResult,
    });
  } catch (error) {
    next(error);
  }
});

storageRouter.post(
  `/multiple`,
  upload.array("files", 10),
  async (req, res, next) => {
    try {
      if (!req.files || !Array.isArray(req.files)) {
        return res.status(400).send("No hay archivos a subir.");
      }

      const uploadResults = await storeService.uploadMultipleFiles(req.files);

      return res.status(200).json({
        message: "¡Los archivos fueron guardados de manera exitosa!",
        files: uploadResults,
      });
    } catch (error) {
      next(error);
    }
  }
);

export default storageRouter;
