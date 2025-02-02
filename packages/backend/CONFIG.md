
# Configuration
### Adopte-up-prof APP environment configuration.
  
| Key | Default | Description | Validators | Protected |
|:--- | :--- | :--- | :--- | :---|
| HF_APP_PORT | 3000 | Port to listen on | isPortNumber | No |
| HF_APP_ENV | dev | Environment to run in | isEnum | No |
| HF_APP_VERBOSE | true | Enable debug mode | isBoolean | No |
| HF_APP_URLS_WHITELIST | http://localhost:4200, http://localhost:8080 | List of urls to proxy | isUrlArray | No |
| HF_APP_FRONTEND_URL | http://localhost:4200 | Path of the frontend | isString | No |
| HF_APP_LOGS_PATH | ./logs/hollyfilms.log | Path of the logs | isString | No |
| HF_APP_DATASTORE_PATH | ../../data | Path of misc files | isString | No |
| HF_DB_HOST | 127.0.0.1 | Database host | isString | Yes |
| HF_DB_NAME |  | Database name |  | No |
| HF_DB_USER |  | Database user |  | Yes |
| HF_DB_PASSWORD |  | Database password |  | Yes |
| HF_DB_PORT |  | Database port |  | No |
| HF_SSL_ENABLED | false | Is database ssl enabled | isBoolean | No |
| HF_SSL_KEY_PATH | /ssl/hollyfilms.key | SSL key path | isString | No |
| HF_SSL_CERT_PATH | /ssl/hollyfilms.crt | SSL cert path | isString | No |
| HF_SSL_PASSPHRASE |  | SSL cert pass | isString | Yes |
| HF_JWT_SECRET | myverysecretkey | JWT secret | isString | Yes |
| HF_JWT_EXPIRE_IN | 1-day | JWT expiration time | isValidPeriod, isString | No |
| HF_RTOKEN_LENGTH | 32 | RToken expiration time | isNumber | No |
| HF_RTOKEN_EXPIRE_IN | 1-day | RToken expiration time | isValidPeriod, isString | No |
| HF_COOKIE_NAME | hollynetes | Cookie name | isString | No |
| HF_COOKIE_EXPIRES_IN | 1-year | Cookie expiration time | isValidPeriod, isString | No |
| HF_COOKIE_SECURE | false | Cookie secure | isBoolean | No |
| HF_MAILS_HOST | localhost | Mail host | isString | No |
| HF_MAILS_USER | noreply@hollynetes.fr | Mail user | isEmail, isString | No |
| HF_MAILS_PASSWORD | default | Mail password | isString | Yes |
| HF_MAILS_USER_TAG | HollyNetes | Mail user tag | isString | No |
| HF_ADMIN_EMAIL | admin@hollynetes.fr | Admin email | isEmail, isString | No |
| HF_ADMIN_PASSWORD | admin | Admin password | isString | Yes |
| HF_TMDB_API_KEY |  | TMBD api key | isString | Yes |
| HF_TMDB_API_URL | https://api.themoviedb.org/3 | TMBD api url | isString | No |
| HF_MEDIAS_FFMPEG_PATH | C:/ffmpeg/bin/ffmpeg.exe | Path of the ffmpeg executable | isString | No |
| HF_MEDIAS_FFPROBE_PATH | C:/ffmpeg/bin/ffprobe.exe | Path of the ffprobe executable | isString | No |
| HF_MEDIAS_PATH_PRIMARY | ../../medias_primary | Path where the videos will be stored as primary | isString | No |
| HF_MEDIAS_PATH_SECONDARY | ../../medias_secondary | Path where the videos will be stored as secondary | isString | No |
| HF_MEDIAS_PATH_TERTIARY | ../../medias_tertiary | Path where the videos will be stored as tertiary | isString | No |
| HF_MEDIAS_PATH_QUATERNARY | ../../medias_quaternary | Path where the videos will be stored as quaternary | isString | No |
| HF_MEDIAS_FILES_PATH | ../../data/medias_files | Path where the videos files are stored before upload | isString | No |
| HF_GOOGLE_AUTH_CLIENT_ID |  | OAuth client id | isString | No |
| HF_GOOGLE_AUTH_CLIENT_SECRET |  | OAuth client secret | isString | Yes |
| HF_REDIS_HOST | localhost | Redis cache host | isString | No |
| HF_REDIS_PORT | 6379 | Redis cache port number | isNumber | No |
| HF_REDIS_PASSWORD |  | Redis cache password | isString | Yes |

Generated on 07/12/2023 14:24:55