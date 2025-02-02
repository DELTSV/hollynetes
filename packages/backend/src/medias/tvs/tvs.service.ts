import {
  forwardRef,
  HttpException,
  Inject,
  Injectable,
  Logger,
} from "@nestjs/common";
import { UsersService } from "../../indentity/users/users.service";
import { InjectModel } from "@nestjs/mongoose";
import { Media, MediaDocument } from "../media.schema";
import { Model } from "mongoose";
import { TmdbService } from "../../tmdb/tmdb.service";
import { MediaWithType } from "../medias.utils";
import * as fs from "fs";

@Injectable()
export class TvsService {
  private logger = new Logger("Tvs");

  constructor(
    @InjectModel(Media.name) private mediaModel: Model<MediaDocument>,
    @Inject(forwardRef(() => UsersService))
    private readonly tmdbService: TmdbService,
  ) {}

  async findAll(): Promise<Media[]> {
    return this.mediaModel
      .find({
        tvs: { $exists: true },
      })
      .exec();
  }

  add(tmdbId: number): Promise<MediaWithType> {
    this.logger.verbose(`Adding tv ${tmdbId}`);

    return this.tmdbService.getTv(tmdbId).then((tv) => {
      this.logger.log(`Added tv ${tv.data.title}`);
      return this.mediaModel.create(tv.data).then((media) => ({
        data: media,
        mediaType: "tv",
      }));
    });
  }

  async addSeason(id: string, seasonIndex: number): Promise<Media> {
    this.logger.verbose(`Adding season ${seasonIndex} of tv ${id}`);
    return this.mediaModel
      .findById(id)
      .orFail(() => {
        this.logger.error(`Tv ${id} not found`);
        throw new HttpException("Tv not found", 404);
      })
      .exec()
      .then(async (media) => {
        return this.mediaModel
          .findByIdAndUpdate(id, {
            $set: {
              [`tvs.${seasonIndex - 1}.episodes`]:
                await this.tmdbService.getEpisodes(media.TMDB_id, seasonIndex),
              [`tvs.${seasonIndex - 1}.dateAdded`]: new Date(),
            },
          })
          .exec();
      });
  }

  async addEpisode(
    mediaId: string,
    seasonIndex: number,
    episodeIndex: number,
    filePath: string
  ) {
    if (!fs.existsSync(filePath)) {
      this.logger.error(`File ${filePath} does not exist`);
      throw new HttpException("File not found", 404);
    }

    this.finalizeProcess(
      mediaId,
      seasonIndex,
      episodeIndex
    );
  }

  finalizeProcess(
    mediaId: string,
    seasonIndex: number,
    episodeIndex: number
  ) {
    this.logger.log(
      `Finalizing process of tv ${mediaId} S${seasonIndex} E${episodeIndex}`
    );
    return this.mediaModel
      .findByIdAndUpdate(mediaId, {
        $set: {
          available: true,
          [`tvs.${seasonIndex - 1}.available`]: true,
          [`tvs.${seasonIndex - 1}.episodes.${episodeIndex - 1}.available`]:
            true,
        },
      })
      .exec();
  }
}
