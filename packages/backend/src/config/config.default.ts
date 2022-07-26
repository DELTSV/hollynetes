import { ConfigEnvironmentDto } from './config.environment.dto';

export enum Environment {
  DEV = 'dev',
  STAGING = 'staging',
  PROD = 'prod',
  TEST = 'test',
}

export const defaultConfig: ConfigEnvironmentDto = {
  HF_APP_PORT: 3000,
  HF_APP_ENV: Environment.DEV,
  HF_APP_VERBOSE: false,
  HF_APP_URLS_WHITELIST: ['http://localhost:4200'],
  HF_APP_FRONTEND_URL: 'http://localhost:4200',

  // Database
  HF_DB_HOST: 'localhost',
  HF_DB_NAME: null,
  HF_DB_USER: null,
  HF_DB_PASSWORD: null,
  HF_DB_PORT: null,

  // SSL
  HF_SSL_ENABLED: false,
  HF_SSL_KEY_PATH: '/ssl/hollyfilms.key',
  HF_SSL_CERT_PATH: '/ssl/hollyfilms.crt',

  // JWT
  HF_JWT_SECRET: 'myverysecretkey',
  HF_JWT_EXPIRE_IN: '1-day',

  // RToken
  HF_RTOKEN_LENGTH: 32,
  HF_RTOKEN_EXPIRE_IN: '1-day',

  // Cookie
  HF_COOKIE_NAME: 'hollyfilms',
  HF_COOKIE_EXPIRES_IN: '1-year',
  HF_COOKIE_SECURE: false,

  // Mail
  HF_MAILS_HOST: null,
  HF_MAILS_USER: null,
  HF_MAILS_PASSWORD: null,
  HF_MAILS_USER_TAG: 'HollyFilms',

  // Admin
  HF_ADMIN_EMAIL: 'admin@hollyfilms.fr',
  HF_ADMIN_PASSWORD: 'admin',

  // TMDB
  HF_TMDB_API_KEY: null,
  HF_TMDB_API_URL: 'https://api.themoviedb.org/3',

  // Medias
  HF_MEDIAS_FFMPEG_PATH: 'C:/ffmpeg/bin/ffmpeg.exe',
  HF_MEDIAS_FFPROBE_PATH: 'C:/ffmpeg/bin/ffprobe.exe',
  HF_MEDIAS_PATH_DEFAULT: '../../medias_default',
  HF_MEDIAS_PATH_SECONDARY: '../../medias_secondary',
};
