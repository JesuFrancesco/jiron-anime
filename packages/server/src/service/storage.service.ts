import { sb } from "../app";
import boom from "@hapi/boom";

export class StorageService {
  private bucketName: string = "images";

  async uploadSingleFile(file: Express.Multer.File) {
    if (!file) {
      throw boom.badRequest("No hay archivo que subir.");
    }

    const filePath = `uploads/${Date.now()}-${file.originalname}`;

    console.log("INICIANDO SUBIDA");

    try {
      const { data, error } = await sb.storage
        .from(this.bucketName)
        .upload(filePath, file.buffer, {
          contentType: "image/*",
          cacheControl: "3600",
          upsert: false,
        });

      if (error) {
        throw error;
      }

      const publicUrl = sb.storage.from(this.bucketName).getPublicUrl(filePath)
        .data.publicUrl;

      return {
        originalName: file.originalname,
        filePath: data.path,
        publicUrl: publicUrl,
      };
    } catch (error) {
      throw error;
    }
  }

  async uploadMultipleFiles(files: Express.Multer.File[]) {
    if (!files || !Array.isArray(files)) {
      throw boom.badRequest("No files uploaded.");
    }

    const uploadResults = await Promise.all(
      files.map(async (file) => {
        const filePath = `uploads/${Date.now()}-${file.originalname}`;
        const { data, error } = await sb.storage
          .from(this.bucketName)
          .upload(filePath, file.buffer, {
            contentType: "image/*",
            cacheControl: "3600",
            upsert: false,
          });

        if (error) {
          throw error;
        }

        const publicUrl = sb.storage
          .from(this.bucketName)
          .getPublicUrl(filePath).data.publicUrl;

        return {
          originalName: file.originalname,
          filePath: data.path,
          publicUrl: publicUrl,
        };
      })
    );

    return uploadResults;
  }
}
