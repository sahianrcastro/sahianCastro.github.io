
import mdx from "@astrojs/mdx";
import react from "@astrojs/react";
import sitemap from "@astrojs/sitemap";
import tailwind from "@astrojs/tailwind";
import AutoImport from "astro-auto-import";
import { defineConfig } from "astro/config";
import remarkCollapse from "remark-collapse";
import remarkToc from "remark-toc";
import rehypeKatex from "rehype-katex";
import remarkMath from "remark-math";

// https://astro.build/config
export default defineConfig({
  site: "https://sahianrcastro.github.io",
  // El repositorio se llama "sahianCastro.github.io" (distinto del usuario "sahianrcastro"),
  // por eso GitHub Pages lo publica en /sahianCastro.github.io/.
  // Si algún día renombras el repo a "sahianrcastro.github.io", cambia base a "/".
  base: "/sahianCastro.github.io",
  trailingSlash: "ignore",
  vite: {
    // Corrige el error "does not provide an export named 'default'" de react-lite-youtube-embed al compilar
    ssr: {
      noExternal: ["react-lite-youtube-embed"]
    }
  },
  prefetch: {
    prefetchAll: true
  },
  integrations: [
    react(),
    sitemap({
      // Solo las páginas propias del portafolio (no las de la plantilla).
      filter: (page) =>
        /\/sahianCastro\.github\.io\/(presentacion\/?|evidencias(\/.*)?)?$/.test(page)
    }),
    tailwind({
      config: {
        applyBaseStyles: false
      }
    }),
    AutoImport({
      imports: [
        "@components/common/Button.astro",
        "@shortcodes/Accordion",
        "@shortcodes/Notice",
        "@shortcodes/Youtube",
        "@shortcodes/Tabs",
        "@shortcodes/Tab"
      ]
    }),
    mdx()
  ],
  markdown: {
    remarkPlugins: [
      remarkToc,
      [
        remarkCollapse,
        {
          test: "Table of contents"
        }
      ],
      remarkMath
    ],
    rehypePlugins: [[rehypeKatex, {}]],
    shikiConfig: {
      themes: {
        light: "light-plus",
        dark: "dark-plus"
      }
    },
    extendDefaultPlugins: true
  }
});
