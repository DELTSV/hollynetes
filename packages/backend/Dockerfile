FROM node:18 as build

WORKDIR /usr/local/app

COPY ./ /usr/local/app/

RUN npm run build

npm prune --omit=dev

FROM node:18

WORKDIR /usr/local/app

COPY --from=build /usr/local/app/node_modules ./node_modules
COPY --from=build /usr/local/app/dist .

CMD [ "node", "main.js" ]

EXPOSE 3000
