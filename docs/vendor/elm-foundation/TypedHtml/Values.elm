module TypedHtml.Values exposing
    ( Blocking, Charset, Closedby, Colorspace, Crossorigin, Decoding, Enctype, Fetchpriority, Formenctype, Formmethod, HttpEquiv, Kind, Loading, Method, Popovertargetaction, Preload, Referrerpolicy, Sandbox, Scope, Shadowrootmode, Shadowrootslotassignment, Shape, Wrap
    , value, allowDownloads, allowForms, allowModals, allowOrientationLock, allowPointerLock, allowPopups, allowPopupsToEscapeSandbox, allowPresentation, allowSameOrigin, allowScripts, allowTopNavigation, allowTopNavigationByUserActivation, allowTopNavigationToCustomProtocols, anonymous, any, applicationXWwwFormUrlencoded, async, auto, captions, chapters, circle, closed, closerequest, col, colgroup, contentSecurityPolicy, contentType, default, defaultStyle, descriptions, dialog, displayP3, eager, get, hard, hide, high, lazy, limitedSrgb, low, manual, metadata, multipartFormData, named, noReferrer, noReferrerWhenDowngrade, none, open, origin, originWhenCrossOrigin, poly, post, rect, refresh, render, row, rowgroup, sameOrigin, show, soft, strictOrigin, strictOriginWhenCrossOrigin, subtitles, sync, textPlain, toggle, unsafeUrl, useCredentials, utf8, xUaCompatible
    )

{-| The enum-value vocabulary: every token minted once (open row), plus the
library-wide union row per enum attribute. General setters close over the
union; per-component setters narrow — both are fed by these same tokens.

@docs Blocking, Charset, Closedby, Colorspace, Crossorigin, Decoding, Enctype, Fetchpriority, Formenctype, Formmethod, HttpEquiv, Kind, Loading, Method, Popovertargetaction, Preload, Referrerpolicy, Sandbox, Scope, Shadowrootmode, Shadowrootslotassignment, Shape, Wrap
@docs value, allowDownloads, allowForms, allowModals, allowOrientationLock, allowPointerLock, allowPopups, allowPopupsToEscapeSandbox, allowPresentation, allowSameOrigin, allowScripts, allowTopNavigation, allowTopNavigationByUserActivation, allowTopNavigationToCustomProtocols, anonymous, any, applicationXWwwFormUrlencoded, async, auto, captions, chapters, circle, closed, closerequest, col, colgroup, contentSecurityPolicy, contentType, default, defaultStyle, descriptions, dialog, displayP3, eager, get, hard, hide, high, lazy, limitedSrgb, low, manual, metadata, multipartFormData, named, noReferrer, noReferrerWhenDowngrade, none, open, origin, originWhenCrossOrigin, poly, post, rect, refresh, render, row, rowgroup, sameOrigin, show, soft, strictOrigin, strictOriginWhenCrossOrigin, subtitles, sync, textPlain, toggle, unsafeUrl, useCredentials, utf8, xUaCompatible

-}

import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value exposing (Value)


{-| The union row for `blocking`.
-}
type alias Blocking =
    { render : Supported
    }


{-| The union row for `charset`.
-}
type alias Charset =
    { utf8 : Supported
    }


{-| The union row for `closedby`.
-}
type alias Closedby =
    { any : Supported
    , closerequest : Supported
    , none : Supported
    }


{-| The union row for `colorspace`.
-}
type alias Colorspace =
    { displayP3 : Supported
    , limitedSrgb : Supported
    }


{-| The union row for `crossorigin`.
-}
type alias Crossorigin =
    { value : Supported
    , anonymous : Supported
    , useCredentials : Supported
    }


{-| The union row for `decoding`.
-}
type alias Decoding =
    { async : Supported
    , auto : Supported
    , sync : Supported
    }


{-| The union row for `enctype`.
-}
type alias Enctype =
    { applicationXWwwFormUrlencoded : Supported
    , multipartFormData : Supported
    , textPlain : Supported
    }


{-| The union row for `fetchpriority`.
-}
type alias Fetchpriority =
    { auto : Supported
    , high : Supported
    , low : Supported
    }


{-| The union row for `formenctype`.
-}
type alias Formenctype =
    { applicationXWwwFormUrlencoded : Supported
    , multipartFormData : Supported
    , textPlain : Supported
    }


{-| The union row for `formmethod`.
-}
type alias Formmethod =
    { dialog : Supported
    , get : Supported
    , post : Supported
    }


{-| The union row for `httpEquiv`.
-}
type alias HttpEquiv =
    { contentSecurityPolicy : Supported
    , contentType : Supported
    , defaultStyle : Supported
    , refresh : Supported
    , xUaCompatible : Supported
    }


{-| The union row for `kind`.
-}
type alias Kind =
    { captions : Supported
    , chapters : Supported
    , descriptions : Supported
    , metadata : Supported
    , subtitles : Supported
    }


{-| The union row for `loading`.
-}
type alias Loading =
    { eager : Supported
    , lazy : Supported
    }


{-| The union row for `method`.
-}
type alias Method =
    { dialog : Supported
    , get : Supported
    , post : Supported
    }


{-| The union row for `popovertargetaction`.
-}
type alias Popovertargetaction =
    { hide : Supported
    , show : Supported
    , toggle : Supported
    }


{-| The union row for `preload`.
-}
type alias Preload =
    { value : Supported
    , auto : Supported
    , metadata : Supported
    , none : Supported
    }


{-| The union row for `referrerpolicy`.
-}
type alias Referrerpolicy =
    { value : Supported
    , noReferrer : Supported
    , noReferrerWhenDowngrade : Supported
    , origin : Supported
    , originWhenCrossOrigin : Supported
    , sameOrigin : Supported
    , strictOrigin : Supported
    , strictOriginWhenCrossOrigin : Supported
    , unsafeUrl : Supported
    }


{-| The union row for `sandbox`.
-}
type alias Sandbox =
    { allowDownloads : Supported
    , allowForms : Supported
    , allowModals : Supported
    , allowOrientationLock : Supported
    , allowPointerLock : Supported
    , allowPopups : Supported
    , allowPopupsToEscapeSandbox : Supported
    , allowPresentation : Supported
    , allowSameOrigin : Supported
    , allowScripts : Supported
    , allowTopNavigation : Supported
    , allowTopNavigationByUserActivation : Supported
    , allowTopNavigationToCustomProtocols : Supported
    }


{-| The union row for `scope`.
-}
type alias Scope =
    { col : Supported
    , colgroup : Supported
    , row : Supported
    , rowgroup : Supported
    }


{-| The union row for `shadowrootmode`.
-}
type alias Shadowrootmode =
    { closed : Supported
    , open : Supported
    }


{-| The union row for `shadowrootslotassignment`.
-}
type alias Shadowrootslotassignment =
    { manual : Supported
    , named : Supported
    }


{-| The union row for `shape`.
-}
type alias Shape =
    { circle : Supported
    , default : Supported
    , poly : Supported
    , rect : Supported
    }


{-| The union row for `wrap`.
-}
type alias Wrap =
    { hard : Supported
    , soft : Supported
    }


{-| The \`\` token.
-}
value : Value { v | value : Supported }
value =
    Ir.token ""


{-| The `allow-downloads` token.
-}
allowDownloads : Value { v | allowDownloads : Supported }
allowDownloads =
    Ir.token "allow-downloads"


{-| The `allow-forms` token.
-}
allowForms : Value { v | allowForms : Supported }
allowForms =
    Ir.token "allow-forms"


{-| The `allow-modals` token.
-}
allowModals : Value { v | allowModals : Supported }
allowModals =
    Ir.token "allow-modals"


{-| The `allow-orientation-lock` token.
-}
allowOrientationLock : Value { v | allowOrientationLock : Supported }
allowOrientationLock =
    Ir.token "allow-orientation-lock"


{-| The `allow-pointer-lock` token.
-}
allowPointerLock : Value { v | allowPointerLock : Supported }
allowPointerLock =
    Ir.token "allow-pointer-lock"


{-| The `allow-popups` token.
-}
allowPopups : Value { v | allowPopups : Supported }
allowPopups =
    Ir.token "allow-popups"


{-| The `allow-popups-to-escape-sandbox` token.
-}
allowPopupsToEscapeSandbox : Value { v | allowPopupsToEscapeSandbox : Supported }
allowPopupsToEscapeSandbox =
    Ir.token "allow-popups-to-escape-sandbox"


{-| The `allow-presentation` token.
-}
allowPresentation : Value { v | allowPresentation : Supported }
allowPresentation =
    Ir.token "allow-presentation"


{-| The `allow-same-origin` token.
-}
allowSameOrigin : Value { v | allowSameOrigin : Supported }
allowSameOrigin =
    Ir.token "allow-same-origin"


{-| The `allow-scripts` token.
-}
allowScripts : Value { v | allowScripts : Supported }
allowScripts =
    Ir.token "allow-scripts"


{-| The `allow-top-navigation` token.
-}
allowTopNavigation : Value { v | allowTopNavigation : Supported }
allowTopNavigation =
    Ir.token "allow-top-navigation"


{-| The `allow-top-navigation-by-user-activation` token.
-}
allowTopNavigationByUserActivation : Value { v | allowTopNavigationByUserActivation : Supported }
allowTopNavigationByUserActivation =
    Ir.token "allow-top-navigation-by-user-activation"


{-| The `allow-top-navigation-to-custom-protocols` token.
-}
allowTopNavigationToCustomProtocols : Value { v | allowTopNavigationToCustomProtocols : Supported }
allowTopNavigationToCustomProtocols =
    Ir.token "allow-top-navigation-to-custom-protocols"


{-| The `anonymous` token.
-}
anonymous : Value { v | anonymous : Supported }
anonymous =
    Ir.token "anonymous"


{-| The `any` token.
-}
any : Value { v | any : Supported }
any =
    Ir.token "any"


{-| The `application/x-www-form-urlencoded` token.
-}
applicationXWwwFormUrlencoded : Value { v | applicationXWwwFormUrlencoded : Supported }
applicationXWwwFormUrlencoded =
    Ir.token "application/x-www-form-urlencoded"


{-| The `async` token.
-}
async : Value { v | async : Supported }
async =
    Ir.token "async"


{-| The `auto` token.
-}
auto : Value { v | auto : Supported }
auto =
    Ir.token "auto"


{-| The `captions` token.
-}
captions : Value { v | captions : Supported }
captions =
    Ir.token "captions"


{-| The `chapters` token.
-}
chapters : Value { v | chapters : Supported }
chapters =
    Ir.token "chapters"


{-| The `circle` token.
-}
circle : Value { v | circle : Supported }
circle =
    Ir.token "circle"


{-| The `closed` token.
-}
closed : Value { v | closed : Supported }
closed =
    Ir.token "closed"


{-| The `closerequest` token.
-}
closerequest : Value { v | closerequest : Supported }
closerequest =
    Ir.token "closerequest"


{-| The `col` token.
-}
col : Value { v | col : Supported }
col =
    Ir.token "col"


{-| The `colgroup` token.
-}
colgroup : Value { v | colgroup : Supported }
colgroup =
    Ir.token "colgroup"


{-| The `content-security-policy` token.
-}
contentSecurityPolicy : Value { v | contentSecurityPolicy : Supported }
contentSecurityPolicy =
    Ir.token "content-security-policy"


{-| The `content-type` token.
-}
contentType : Value { v | contentType : Supported }
contentType =
    Ir.token "content-type"


{-| The `default` token.
-}
default : Value { v | default : Supported }
default =
    Ir.token "default"


{-| The `default-style` token.
-}
defaultStyle : Value { v | defaultStyle : Supported }
defaultStyle =
    Ir.token "default-style"


{-| The `descriptions` token.
-}
descriptions : Value { v | descriptions : Supported }
descriptions =
    Ir.token "descriptions"


{-| The `dialog` token.
-}
dialog : Value { v | dialog : Supported }
dialog =
    Ir.token "dialog"


{-| The `display-p3` token.
-}
displayP3 : Value { v | displayP3 : Supported }
displayP3 =
    Ir.token "display-p3"


{-| The `eager` token.
-}
eager : Value { v | eager : Supported }
eager =
    Ir.token "eager"


{-| The `get` token.
-}
get : Value { v | get : Supported }
get =
    Ir.token "get"


{-| The `hard` token.
-}
hard : Value { v | hard : Supported }
hard =
    Ir.token "hard"


{-| The `hide` token.
-}
hide : Value { v | hide : Supported }
hide =
    Ir.token "hide"


{-| The `high` token.
-}
high : Value { v | high : Supported }
high =
    Ir.token "high"


{-| The `lazy` token.
-}
lazy : Value { v | lazy : Supported }
lazy =
    Ir.token "lazy"


{-| The `limited-srgb` token.
-}
limitedSrgb : Value { v | limitedSrgb : Supported }
limitedSrgb =
    Ir.token "limited-srgb"


{-| The `low` token.
-}
low : Value { v | low : Supported }
low =
    Ir.token "low"


{-| The `manual` token.
-}
manual : Value { v | manual : Supported }
manual =
    Ir.token "manual"


{-| The `metadata` token.
-}
metadata : Value { v | metadata : Supported }
metadata =
    Ir.token "metadata"


{-| The `multipart/form-data` token.
-}
multipartFormData : Value { v | multipartFormData : Supported }
multipartFormData =
    Ir.token "multipart/form-data"


{-| The `named` token.
-}
named : Value { v | named : Supported }
named =
    Ir.token "named"


{-| The `no-referrer` token.
-}
noReferrer : Value { v | noReferrer : Supported }
noReferrer =
    Ir.token "no-referrer"


{-| The `no-referrer-when-downgrade` token.
-}
noReferrerWhenDowngrade : Value { v | noReferrerWhenDowngrade : Supported }
noReferrerWhenDowngrade =
    Ir.token "no-referrer-when-downgrade"


{-| The `none` token.
-}
none : Value { v | none : Supported }
none =
    Ir.token "none"


{-| The `open` token.
-}
open : Value { v | open : Supported }
open =
    Ir.token "open"


{-| The `origin` token.
-}
origin : Value { v | origin : Supported }
origin =
    Ir.token "origin"


{-| The `origin-when-cross-origin` token.
-}
originWhenCrossOrigin : Value { v | originWhenCrossOrigin : Supported }
originWhenCrossOrigin =
    Ir.token "origin-when-cross-origin"


{-| The `poly` token.
-}
poly : Value { v | poly : Supported }
poly =
    Ir.token "poly"


{-| The `post` token.
-}
post : Value { v | post : Supported }
post =
    Ir.token "post"


{-| The `rect` token.
-}
rect : Value { v | rect : Supported }
rect =
    Ir.token "rect"


{-| The `refresh` token.
-}
refresh : Value { v | refresh : Supported }
refresh =
    Ir.token "refresh"


{-| The `render` token.
-}
render : Value { v | render : Supported }
render =
    Ir.token "render"


{-| The `row` token.
-}
row : Value { v | row : Supported }
row =
    Ir.token "row"


{-| The `rowgroup` token.
-}
rowgroup : Value { v | rowgroup : Supported }
rowgroup =
    Ir.token "rowgroup"


{-| The `same-origin` token.
-}
sameOrigin : Value { v | sameOrigin : Supported }
sameOrigin =
    Ir.token "same-origin"


{-| The `show` token.
-}
show : Value { v | show : Supported }
show =
    Ir.token "show"


{-| The `soft` token.
-}
soft : Value { v | soft : Supported }
soft =
    Ir.token "soft"


{-| The `strict-origin` token.
-}
strictOrigin : Value { v | strictOrigin : Supported }
strictOrigin =
    Ir.token "strict-origin"


{-| The `strict-origin-when-cross-origin` token.
-}
strictOriginWhenCrossOrigin : Value { v | strictOriginWhenCrossOrigin : Supported }
strictOriginWhenCrossOrigin =
    Ir.token "strict-origin-when-cross-origin"


{-| The `subtitles` token.
-}
subtitles : Value { v | subtitles : Supported }
subtitles =
    Ir.token "subtitles"


{-| The `sync` token.
-}
sync : Value { v | sync : Supported }
sync =
    Ir.token "sync"


{-| The `text/plain` token.
-}
textPlain : Value { v | textPlain : Supported }
textPlain =
    Ir.token "text/plain"


{-| The `toggle` token.
-}
toggle : Value { v | toggle : Supported }
toggle =
    Ir.token "toggle"


{-| The `unsafe-url` token.
-}
unsafeUrl : Value { v | unsafeUrl : Supported }
unsafeUrl =
    Ir.token "unsafe-url"


{-| The `use-credentials` token.
-}
useCredentials : Value { v | useCredentials : Supported }
useCredentials =
    Ir.token "use-credentials"


{-| The `utf-8` token.
-}
utf8 : Value { v | utf8 : Supported }
utf8 =
    Ir.token "utf-8"


{-| The `x-ua-compatible` token.
-}
xUaCompatible : Value { v | xUaCompatible : Supported }
xUaCompatible =
    Ir.token "x-ua-compatible"
