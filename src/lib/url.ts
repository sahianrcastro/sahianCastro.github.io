// Antepone el "base" de Astro (subcarpeta de GitHub Pages) a las rutas internas.
// Las URLs externas (http, https, mailto, #ancla) se devuelven sin cambios.
export const withBase = (path: string = "/"): string => {
  if (/^([a-z]+:|\/\/|#)/i.test(path)) return path;
  const base = import.meta.env.BASE_URL.replace(/\/$/, "");
  const clean = path.startsWith("/") ? path : `/${path}`;
  return `${base}${clean}`;
};

// Quita el "base" de una ruta para compararla con las rutas del menú.
export const stripBase = (pathname: string): string => {
  const base = import.meta.env.BASE_URL.replace(/\/$/, "");
  let path = base && pathname.startsWith(base) ? pathname.slice(base.length) : pathname;
  if (!path.startsWith("/")) path = `/${path}`;
  return path.length > 1 ? path.replace(/\/$/, "") : path;
};

// Convierte un enlace normal de YouTube o Google Drive en uno embebible.
export const toEmbedUrl = (url: string): string => {
  const yt = url.match(/(?:youtube\.com\/(?:watch\?v=|shorts\/|embed\/)|youtu\.be\/)([\w-]{11})/);
  if (yt) return `https://www.youtube.com/embed/${yt[1]}`;
  const drive = url.match(/drive\.google\.com\/file\/d\/([\w-]+)/);
  if (drive) return `https://drive.google.com/file/d/${drive[1]}/preview`;
  return url;
};

// Convierte un enlace de Spotify (playlist, álbum, canción) en su versión embebible.
export const toSpotifyEmbed = (url: string): string => {
  const m = url.match(/open\.spotify\.com\/(?:intl-[a-z]+\/)?(playlist|album|track|artist|episode|show)\/([A-Za-z0-9]+)/);
  return m ? `https://open.spotify.com/embed/${m[1]}/${m[2]}?utm_source=generator` : "";
};
