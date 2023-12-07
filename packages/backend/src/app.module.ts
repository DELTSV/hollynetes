import {
  DynamicModule,
  Logger,
  MiddlewareConsumer,
  Module,
} from "@nestjs/common";
import { ConfigModule, ConfigService } from "@nestjs/config";
import { MongooseModule } from "@nestjs/mongoose";
import { AppController } from "./app.controller";
import { APIConfig, DatabaseConfig, RedisConfig } from "./config/config";
import { getMongoString } from "./config/config.utils";
import { LogsMiddleware } from "./logger/logs.middleware";

import * as mongoose from "mongoose";
import { IdentityModule } from "./indentity/identity.module";

import colorize = require("json-colorizer");
import { MediasModule } from "./medias/medias.module";
import { TmdbModule } from "./tmdb/tmdb.module";
import { MongooseModuleOptions } from "@nestjs/mongoose/dist/interfaces/mongoose-options.interface";

import { CacheModule } from '@nestjs/cache-manager';
import { redisStore } from 'cache-manager-redis-yet';

@Module({})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(LogsMiddleware).forRoutes("*");
  }

  static register(config: APIConfig): DynamicModule {
    return {
      module: AppModule,
      imports: [
        MongooseModule.forRootAsync({
          imports: [ConfigModule],
          useFactory: async (
            config: ConfigService
          ): Promise<MongooseModuleOptions> => {
            const logger = new Logger("Mongoose");

            mongoose.set("debug", (coll, method, query, doc) => {
              logger.verbose(
                `${coll}.${method} ${colorize(query)} ${colorize(doc)}`
              );
            });

            const uri = getMongoString(config.get<DatabaseConfig>("database"));

            logger.debug(`Connecting to ${uri}`);

            return { uri };
          },
          inject: [ConfigService],
        }),
        ConfigModule.forRoot({
          isGlobal: true,
          ignoreEnvFile: true,
          ignoreEnvVars: true,
          load: [() => config],
          cache: true,
        }),
        CacheModule.registerAsync({
          isGlobal: true,
          imports: [ConfigModule],
          useFactory: async (configService: ConfigService) => {
            const config = configService.get<RedisConfig>('redis');

            return {
              store: await redisStore({
                socket: {
                  host: config.host,
                  port: config.port,
                },
                password: config.password,
              }),
            };
          },
          inject: [ConfigService],
        }),
        IdentityModule,
        MediasModule,
        TmdbModule,
      ],
      providers: [Logger],
      controllers: [AppController],
    };
  }
}
