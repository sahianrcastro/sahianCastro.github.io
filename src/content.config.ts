import { defineCollection, reference, z } from "astro:content";
import { glob } from "astro/loaders";

// May also need to update /src/types/index.d.ts when updating this file
// When updating the set of searchable collections, update collectionList in /src/pages/search.astro

const searchable = z.object({
  title: z.string(),
  description: z.string().optional(),
  autodescription: z.boolean().default(true),
  draft: z.boolean().default(false),
});

const social = z.object({
  discord: z.string().optional(),
  email: z.string().optional(),
  facebook: z.string().optional(),
  github: z.string().optional(),
  instagram: z.string().optional(),
  linkedIn: z.string().optional(),
  pinterest: z.string().optional(),
  tiktok: z.string().optional(),
  website: z.string().optional(),
  youtube: z.string().optional(),
});

const about = defineCollection({
  loader: glob({ pattern: "-index.{md,mdx}", base: "./src/content/about" }),
  schema: ({ image }) =>
    searchable.extend({
      image: image().optional(),
      imageAlt: z.string().default(""),
      fullName: z.string().optional(),
      nickname: z.string().optional(),
      videoUrl: z.string().default(""),
      spotifyUrl: z.string().default(""),
      tools: z
        .array(
          z.object({
            category: z.string(),
            items: z.array(z.string()),
          }),
        )
        .default([]),
    }),
});

const authors = defineCollection({
  loader: glob({
    pattern: "**\/[^_]*.{md,mdx}",
    base: "./src/content/authors",
  }),
  schema: ({ image }) =>
    searchable.extend({
      email: z.string().optional(),
      image: image().optional(),
      imageAlt: z.string().default(""),
      social: social.optional(),
    }),
});

const blog = defineCollection({
  loader: glob({ pattern: "**\/[^_]*.{md,mdx}", base: "./src/content/blog" }),
  schema: ({ image }) =>
    searchable.extend({
      date: z.date().optional(),
      image: image().optional(),
      imageAlt: z.string().default(""),
      author: reference("authors").optional(),
      categories: z.array(z.string()).optional(),
      tags: z.array(z.string()).optional(),
      complexity: z.number().default(1),
      hideToc: z.boolean().default(false),
    }),
});

const docs = defineCollection({
  loader: glob({ pattern: "**\/[^_]*.{md,mdx}", base: "./src/content/docs" }),
  schema: ({ image }) =>
    searchable.extend({
      pubDate: z.date().optional(),
      modDate: z.date().optional(),
      image: image().optional(),
      imageAlt: z.string().default(""),
      hideToc: z.boolean().default(false),
      hideNav: z.boolean().default(false),
    }),
});

const evidencias = defineCollection({
  loader: glob({
    pattern: "**\/[^_]*.{md,mdx}",
    base: "./src/content/evidencias",
  }),
  schema: searchable.extend({
    order: z.number().default(0),
    items: z
      .array(
        z.object({
          title: z.string(),
          description: z.string(),
          image: z.string(),
          preview: z.string().optional(),
          alt: z.string().default(""),
          tags: z.array(z.string()).default([]),
          links: z
            .array(z.object({ label: z.string(), url: z.string() }))
            .default([]),
        }),
      )
      .default([]),
    downloads: z
      .array(z.object({ label: z.string(), url: z.string() }))
      .default([]),
    exercises: z
      .array(
        z.object({
          title: z.string(),
          summary: z.string().optional(),
          steps: z.array(
            z.object({
              label: z.string(),
              status: z.string().optional(),
              rule: z.string().optional(),
              problem: z.array(z.string()).default([]),
              consequence: z.array(z.string()).default([]),
              dependencies: z.array(z.string()).default([]),
              analysis: z.string().optional(),
              tables: z
                .array(
                  z.object({
                    name: z.string(),
                    columns: z.array(z.string()),
                  }),
                )
                .default([]),
            }),
          ),
        }),
      )
      .default([]),
    project: z
      .object({
        title: z.string(),
        tagline: z.string().optional(),
        summary: z.array(z.string()).default([]),
        stack: z.array(z.string()).default([]),
        architecture: z
          .array(
            z.object({
              layer: z.string(),
              tech: z.string(),
              description: z.string(),
            }),
          )
          .default([]),
        resources: z
          .array(
            z.object({
              title: z.string(),
              description: z.string(),
              url: z.string(),
              kind: z.enum(["github", "drive", "folder", "diagram", "link"]).default("link"),
            }),
          )
          .default([]),
      })
      .optional(),
    sql: z
      .object({
        intro: z.array(z.string()).default([]),
        facts: z
          .array(z.object({ value: z.string(), label: z.string() }))
          .default([]),
        notes: z.array(z.string()).default([]),
        groups: z
          .array(
            z.object({
              title: z.string(),
              description: z.string().optional(),
              file: z.string(),
              mode: z.enum(["sections", "queries"]).default("sections"),
              filter: z.enum(["all", "basic", "join"]).default("all"),
              sections: z
                .array(
                  z.object({
                    title: z.string(),
                    description: z.string().optional(),
                    lines: z.tuple([z.number(), z.number()]).optional(),
                  }),
                )
                .default([]),
            }),
          )
          .default([]),
      })
      .optional(),
    comparison: z
      .object({
        title: z.string(),
        headers: z.array(z.string()),
        rows: z.array(z.array(z.string())),
      })
      .optional(),
  }),
});

const home = defineCollection({
  loader: glob({ pattern: "-index.{md,mdx}", base: "./src/content/home" }),
  schema: ({ image }) =>
    z.object({
      image: image().optional(),
      imageAlt: z.string().default(""),
      title: z.string(),
      content: z.string(),
      buttons: z
        .array(
          z.object({
            label: z.string(),
            link: z.string(),
          }),
        )
        .default([]),
    }),
});

const indexCards = defineCollection({
  loader: glob({
    pattern: "-index.{md,mdx}",
    base: "./src/content/index-cards",
  }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    cards: z.array(z.string()),
  }),
});

const poetry = defineCollection({
  loader: glob({ pattern: "**\/[^_]*.{md,mdx}", base: "./src/content/poetry" }),
  schema: ({ image }) =>
    searchable.extend({
      date: z.date().optional(),
      image: image().optional(),
      imageAlt: z.string().default(""),
      author: reference("authors").optional(),
    }),
});

const portfolio = defineCollection({
  loader: glob({
    pattern: "-index.{md,mdx}",
    base: "./src/content/portfolio",
  }),
  schema: searchable.extend({
    projects: z.array(
      z.object({
        title: z.string(),
        github: z.string().optional(),
        technologies: z.array(z.string()).optional(),
        content: z.array(z.string()).optional(),
      }),
    ),
  }),
});

const recipes = defineCollection({
  loader: glob({
    pattern: "**\/[^_]*.{md,mdx}",
    base: "./src/content/recipes",
  }),
  schema: ({ image }) =>
    searchable.extend({
      date: z.date().optional(),
      image: image().optional(),
      imageAlt: z.string().default(""),
      author: reference("authors").optional(),
      prepTime: z.number().optional(),
      servings: z.number().optional(),
      diet: z.string().optional(),
      ingredients: z
        .object({
          list: z.array(z.string()),
          qty: z.array(z.string()),
        })
        .optional(),
      instructions: z.array(z.string()).optional(),
      notes: z.array(z.string()).optional(),
    }),
});

const terms = defineCollection({
  loader: glob({ pattern: "-index.{md,mdx}", base: "./src/content/terms" }),
  schema: searchable,
});

// Export collections
export const collections = {
  about,
  authors,
  blog,
  docs,
  evidencias,
  home,
  indexCards,
  poetry,
  portfolio,
  recipes,
  terms,
};
