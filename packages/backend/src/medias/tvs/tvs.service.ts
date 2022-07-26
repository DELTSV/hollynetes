import { Injectable, Logger } from '@nestjs/common';
import { UsersService } from '../../indentity/users/users.service';
import { InjectModel } from '@nestjs/mongoose';
import { Media, MediaDocument } from '../media.schema';
import { Model } from 'mongoose';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { TMDBConfig } from '../../config/config';
import { firstValueFrom } from 'rxjs';
import { TmdbService } from '../../tmdb/tmdb.service';
import { MediaWithType } from '../medias.utils';

@Injectable()
export class TvsService {
  private logger = new Logger('Tvs');

  constructor(
    @InjectModel(Media.name) private mediaModel: Model<MediaDocument>,
    private readonly userService: UsersService,
    private readonly http: HttpService,
    private readonly tmdbService: TmdbService,
    private readonly configService: ConfigService,
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
        mediaType: 'tv',
      }));
    });
  }

  async addSeason(id: string, seasonIndex: number): Promise<Media> {
    const config = this.configService.get<TMDBConfig>('tmdb');

    this.logger.verbose(`Adding season ${seasonIndex} of tv ${id}`);
    return this.mediaModel
      .findById(id)
      .exec()
      .then(async (media) => {
        const episodes = await firstValueFrom(
          this.http.get(
            `${config.apiUrl}/tv/${media.TMDB_id}/season/${seasonIndex}?api_key=${config.apiKey}&language=en-US&append_to_response=videos,credits,translations,reviews`,
          ),
        )
          .then((response) => response.data.episodes)
          .then((episodes) =>
            episodes.map((episode) => ({
              name: episode.name,
              index: episode.episode_number,
              overview: episode.overview,
              still_path: episode.still_path
                ? 'https://image.tmdb.org/t/p/w1280' + episode.still_path
                : null,
              vote_average: episode.vote_average,
              available: false,
            })),
          );

        return this.mediaModel
          .findById(id)
          .exec()
          .then((media) => {
            this.logger.log(`Added season ${seasonIndex} of tv ${media.title}`);

            media.tvs[seasonIndex - 1].episodes = episodes;
            media.tvs[seasonIndex - 1].available = true;
            media.tvs[seasonIndex - 1].dateAdded = new Date();
            return media.save();
          });
      });
  }

  async addEpisode(
    id: string,
    seasonIndex: number,
    episodeIndex: number,
    filePath: string,
  ): Promise<void> {
    if (id && seasonIndex && episodeIndex && filePath) {
      /*this.processingService.addToQueue({
        fileName: filePath,
        mediaType: 'tv',
        id: id,
        seasonIndex: seasonIndex,
        episodeIndex: episodeIndex,
      });*/
    }

    return;
  }
}
