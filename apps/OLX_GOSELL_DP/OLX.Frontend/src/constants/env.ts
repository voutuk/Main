const SERVER_HOST: string = import.meta.env.VITE_APP_SERVER_HOST;
const API_URL: string = SERVER_HOST + '/api'
const IMAGES_FOLDER: string = import.meta.env.VITE_APP_IMAGES_FOLDER;
const IMAGES_URL: string = SERVER_HOST + IMAGES_FOLDER;
const IMAGES_100_URL: string = IMAGES_URL + '/100_';
const IMAGES_200_URL: string = IMAGES_URL + '/200_';
const IMAGES_400_URL: string = IMAGES_URL + '/400_';
const IMAGES_800_URL: string = IMAGES_URL + '/800_';
const IMAGES_1200_URL: string = IMAGES_URL + '/1200_';
const ACCESS_KEY: string = import.meta.env.VITE_APP_ACCESS_KEY;
const REFRESH_KEY: string = import.meta.env.VITE_APP_REFRESH_KEY;
const APP_MODE: string = import.meta.env.VITE_APP_APP_MODE;
const GOOGLE_CLIENT_ID: string = import.meta.env.VITE_APP_GOOGLE_CLIENT_ID;
const RECAPTCHA_SITE_KEY: string = import.meta.env.VITE_APP_RECAPTCHA_SITE_KEY;
const VIEWED_KEY: string = import.meta.env.VITE_APP_VIEWED_KEY
const FAVORITES_KEY: string = import.meta.env.VITE_APP_FAVORITES_KEY

export const APP_ENV = {
    API_URL,
    SERVER_HOST,
    IMAGES_FOLDER,
    IMAGES_URL,
    IMAGES_100_URL,
    IMAGES_200_URL,
    IMAGES_400_URL,
    IMAGES_800_URL,
    IMAGES_1200_URL,
    ACCESS_KEY,
    APP_MODE,
    GOOGLE_CLIENT_ID,
    RECAPTCHA_SITE_KEY,
    REFRESH_KEY,
    VIEWED_KEY,
    FAVORITES_KEY
};