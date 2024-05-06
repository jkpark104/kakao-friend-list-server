FROM node:20.11.0

COPY ./package.json /myfolder/
COPY ./pnpm-lock.yaml /myfolder/
COPY ./tsconfig.json /myfolder/
COPY ./tsconfig.build.json /myfolder/
WORKDIR /myfolder
RUN npm install -g pnpm
RUN pnpm install --frozen-lockfile --prod
RUN pnpm build

COPY . /myfolder

CMD pnpm start:prod
