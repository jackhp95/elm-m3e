module Site exposing (config)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import SiteConfig exposing (SiteConfig)


config : SiteConfig
config =
    { -- The site's own canonical origin (feeds canonical <link> tags + sitemap).
      -- Was the elm-pages template placeholder ("https://elm-pages.com"), which
      -- emitted canonical URLs pointing at a different site. Set to the Netlify
      -- default derived from the repo slug; update to the real deployed origin
      -- if a custom domain is configured.
      canonicalUrl = "https://elm-m3e.netlify.app"
    , head = head
    }


head : BackendTask FatalError (List Head.Tag)
head =
    [ Head.metaName "viewport" (Head.raw "width=device-width,initial-scale=1")
    , Head.sitemapLink "/sitemap.xml"
    ]
        |> BackendTask.succeed
