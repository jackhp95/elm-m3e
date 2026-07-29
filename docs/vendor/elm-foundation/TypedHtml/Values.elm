module TypedHtml.Values exposing
    ( Blocking, Charset, Closedby, Colorspace, Crossorigin, Decoding, Enctype, Fetchpriority, Formenctype, Formmethod, HttpEquiv, Kind, Loading, Method, Popovertargetaction, Preload, Referrerpolicy, Sandbox, Scope, Shadowrootmode, Shadowrootslotassignment, Shape, Wrap
    , value, allowDownloads, allowForms, allowModals, allowOrientationLock, allowPointerLock, allowPopups, allowPopupsToEscapeSandbox, allowPresentation, allowSameOrigin, allowScripts, allowTopNavigation, allowTopNavigationByUserActivation, allowTopNavigationToCustomProtocols, anonymous, any, applicationXWwwFormUrlencoded, async, auto, captions, chapters, circle, closed, closerequest, col, colgroup, contentSecurityPolicy, contentType, default, defaultStyle, descriptions, dialog, displayP3, eager, get, hard, hide, high, lazy, limitedSrgb, low, manual, metadata, multipartFormData, named, noReferrer, noReferrerWhenDowngrade, none, open, origin, originWhenCrossOrigin, poly, post, rect, refresh, render, row, rowgroup, sameOrigin, show, soft, strictOrigin, strictOriginWhenCrossOrigin, subtitles, sync, textPlain, toggle, unsafeUrl, useCredentials, utf8, xUaCompatible
    , blockingRender, charsetUtf8, closedbyAny, closedbyCloserequest, closedbyNone, colorspaceDisplayP3, colorspaceLimitedSrgb, crossoriginValue, crossoriginAnonymous, crossoriginUseCredentials, decodingAsync, decodingAuto, decodingSync, enctypeApplicationXWwwFormUrlencoded, enctypeMultipartFormData, enctypeTextPlain, fetchpriorityAuto, fetchpriorityHigh, fetchpriorityLow, formenctypeApplicationXWwwFormUrlencoded, formenctypeMultipartFormData, formenctypeTextPlain, formmethodDialog, formmethodGet, formmethodPost, httpEquivContentSecurityPolicy, httpEquivContentType, httpEquivDefaultStyle, httpEquivRefresh, httpEquivXUaCompatible, kindCaptions, kindChapters, kindDescriptions, kindMetadata, kindSubtitles, loadingEager, loadingLazy, methodDialog, methodGet, methodPost, popovertargetactionHide, popovertargetactionShow, popovertargetactionToggle, preloadValue, preloadAuto, preloadMetadata, preloadNone, referrerpolicyValue, referrerpolicyNoReferrer, referrerpolicyNoReferrerWhenDowngrade, referrerpolicyOrigin, referrerpolicyOriginWhenCrossOrigin, referrerpolicySameOrigin, referrerpolicyStrictOrigin, referrerpolicyStrictOriginWhenCrossOrigin, referrerpolicyUnsafeUrl, sandboxAllowDownloads, sandboxAllowForms, sandboxAllowModals, sandboxAllowOrientationLock, sandboxAllowPointerLock, sandboxAllowPopups, sandboxAllowPopupsToEscapeSandbox, sandboxAllowPresentation, sandboxAllowSameOrigin, sandboxAllowScripts, sandboxAllowTopNavigation, sandboxAllowTopNavigationByUserActivation, sandboxAllowTopNavigationToCustomProtocols, scopeCol, scopeColgroup, scopeRow, scopeRowgroup, shadowrootmodeClosed, shadowrootmodeOpen, shadowrootslotassignmentManual, shadowrootslotassignmentNamed, shapeCircle, shapeDefault, shapePoly, shapeRect, wrapHard, wrapSoft
    )

{-| The enum-value vocabulary: every token minted once (open row), plus the
library-wide union row per enum attribute, plus attribute-prefixed
portmanteaus (`variantFilled`, `shapeRounded`, …) for IDE discovery.
General setters close over the union; per-component setters narrow — both
are fed by these same tokens.

@docs Blocking, Charset, Closedby, Colorspace, Crossorigin, Decoding, Enctype, Fetchpriority, Formenctype, Formmethod, HttpEquiv, Kind, Loading, Method, Popovertargetaction, Preload, Referrerpolicy, Sandbox, Scope, Shadowrootmode, Shadowrootslotassignment, Shape, Wrap
@docs value, allowDownloads, allowForms, allowModals, allowOrientationLock, allowPointerLock, allowPopups, allowPopupsToEscapeSandbox, allowPresentation, allowSameOrigin, allowScripts, allowTopNavigation, allowTopNavigationByUserActivation, allowTopNavigationToCustomProtocols, anonymous, any, applicationXWwwFormUrlencoded, async, auto, captions, chapters, circle, closed, closerequest, col, colgroup, contentSecurityPolicy, contentType, default, defaultStyle, descriptions, dialog, displayP3, eager, get, hard, hide, high, lazy, limitedSrgb, low, manual, metadata, multipartFormData, named, noReferrer, noReferrerWhenDowngrade, none, open, origin, originWhenCrossOrigin, poly, post, rect, refresh, render, row, rowgroup, sameOrigin, show, soft, strictOrigin, strictOriginWhenCrossOrigin, subtitles, sync, textPlain, toggle, unsafeUrl, useCredentials, utf8, xUaCompatible
@docs blockingRender, charsetUtf8, closedbyAny, closedbyCloserequest, closedbyNone, colorspaceDisplayP3, colorspaceLimitedSrgb, crossoriginValue, crossoriginAnonymous, crossoriginUseCredentials, decodingAsync, decodingAuto, decodingSync, enctypeApplicationXWwwFormUrlencoded, enctypeMultipartFormData, enctypeTextPlain, fetchpriorityAuto, fetchpriorityHigh, fetchpriorityLow, formenctypeApplicationXWwwFormUrlencoded, formenctypeMultipartFormData, formenctypeTextPlain, formmethodDialog, formmethodGet, formmethodPost, httpEquivContentSecurityPolicy, httpEquivContentType, httpEquivDefaultStyle, httpEquivRefresh, httpEquivXUaCompatible, kindCaptions, kindChapters, kindDescriptions, kindMetadata, kindSubtitles, loadingEager, loadingLazy, methodDialog, methodGet, methodPost, popovertargetactionHide, popovertargetactionShow, popovertargetactionToggle, preloadValue, preloadAuto, preloadMetadata, preloadNone, referrerpolicyValue, referrerpolicyNoReferrer, referrerpolicyNoReferrerWhenDowngrade, referrerpolicyOrigin, referrerpolicyOriginWhenCrossOrigin, referrerpolicySameOrigin, referrerpolicyStrictOrigin, referrerpolicyStrictOriginWhenCrossOrigin, referrerpolicyUnsafeUrl, sandboxAllowDownloads, sandboxAllowForms, sandboxAllowModals, sandboxAllowOrientationLock, sandboxAllowPointerLock, sandboxAllowPopups, sandboxAllowPopupsToEscapeSandbox, sandboxAllowPresentation, sandboxAllowSameOrigin, sandboxAllowScripts, sandboxAllowTopNavigation, sandboxAllowTopNavigationByUserActivation, sandboxAllowTopNavigationToCustomProtocols, scopeCol, scopeColgroup, scopeRow, scopeRowgroup, shadowrootmodeClosed, shadowrootmodeOpen, shadowrootslotassignmentManual, shadowrootslotassignmentNamed, shapeCircle, shapeDefault, shapePoly, shapeRect, wrapHard, wrapSoft

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


{-| The `render` value of the `blocking` enum — same open row as `render`, prefixed for discovery.
-}
blockingRender : Value { v | render : Supported }
blockingRender =
    Ir.token "render"


{-| The `utf-8` value of the `charset` enum — same open row as `utf8`, prefixed for discovery.
-}
charsetUtf8 : Value { v | utf8 : Supported }
charsetUtf8 =
    Ir.token "utf-8"


{-| The `any` value of the `closedby` enum — same open row as `any`, prefixed for discovery.
-}
closedbyAny : Value { v | any : Supported }
closedbyAny =
    Ir.token "any"


{-| The `closerequest` value of the `closedby` enum — same open row as `closerequest`, prefixed for discovery.
-}
closedbyCloserequest : Value { v | closerequest : Supported }
closedbyCloserequest =
    Ir.token "closerequest"


{-| The `none` value of the `closedby` enum — same open row as `none`, prefixed for discovery.
-}
closedbyNone : Value { v | none : Supported }
closedbyNone =
    Ir.token "none"


{-| The `display-p3` value of the `colorspace` enum — same open row as `displayP3`, prefixed for discovery.
-}
colorspaceDisplayP3 : Value { v | displayP3 : Supported }
colorspaceDisplayP3 =
    Ir.token "display-p3"


{-| The `limited-srgb` value of the `colorspace` enum — same open row as `limitedSrgb`, prefixed for discovery.
-}
colorspaceLimitedSrgb : Value { v | limitedSrgb : Supported }
colorspaceLimitedSrgb =
    Ir.token "limited-srgb"


{-| The \``value of the`crossorigin`enum — same open row as`value\`, prefixed for discovery.
-}
crossoriginValue : Value { v | value : Supported }
crossoriginValue =
    Ir.token ""


{-| The `anonymous` value of the `crossorigin` enum — same open row as `anonymous`, prefixed for discovery.
-}
crossoriginAnonymous : Value { v | anonymous : Supported }
crossoriginAnonymous =
    Ir.token "anonymous"


{-| The `use-credentials` value of the `crossorigin` enum — same open row as `useCredentials`, prefixed for discovery.
-}
crossoriginUseCredentials : Value { v | useCredentials : Supported }
crossoriginUseCredentials =
    Ir.token "use-credentials"


{-| The `async` value of the `decoding` enum — same open row as `async`, prefixed for discovery.
-}
decodingAsync : Value { v | async : Supported }
decodingAsync =
    Ir.token "async"


{-| The `auto` value of the `decoding` enum — same open row as `auto`, prefixed for discovery.
-}
decodingAuto : Value { v | auto : Supported }
decodingAuto =
    Ir.token "auto"


{-| The `sync` value of the `decoding` enum — same open row as `sync`, prefixed for discovery.
-}
decodingSync : Value { v | sync : Supported }
decodingSync =
    Ir.token "sync"


{-| The `application/x-www-form-urlencoded` value of the `enctype` enum — same open row as `applicationXWwwFormUrlencoded`, prefixed for discovery.
-}
enctypeApplicationXWwwFormUrlencoded : Value { v | applicationXWwwFormUrlencoded : Supported }
enctypeApplicationXWwwFormUrlencoded =
    Ir.token "application/x-www-form-urlencoded"


{-| The `multipart/form-data` value of the `enctype` enum — same open row as `multipartFormData`, prefixed for discovery.
-}
enctypeMultipartFormData : Value { v | multipartFormData : Supported }
enctypeMultipartFormData =
    Ir.token "multipart/form-data"


{-| The `text/plain` value of the `enctype` enum — same open row as `textPlain`, prefixed for discovery.
-}
enctypeTextPlain : Value { v | textPlain : Supported }
enctypeTextPlain =
    Ir.token "text/plain"


{-| The `auto` value of the `fetchpriority` enum — same open row as `auto`, prefixed for discovery.
-}
fetchpriorityAuto : Value { v | auto : Supported }
fetchpriorityAuto =
    Ir.token "auto"


{-| The `high` value of the `fetchpriority` enum — same open row as `high`, prefixed for discovery.
-}
fetchpriorityHigh : Value { v | high : Supported }
fetchpriorityHigh =
    Ir.token "high"


{-| The `low` value of the `fetchpriority` enum — same open row as `low`, prefixed for discovery.
-}
fetchpriorityLow : Value { v | low : Supported }
fetchpriorityLow =
    Ir.token "low"


{-| The `application/x-www-form-urlencoded` value of the `formenctype` enum — same open row as `applicationXWwwFormUrlencoded`, prefixed for discovery.
-}
formenctypeApplicationXWwwFormUrlencoded : Value { v | applicationXWwwFormUrlencoded : Supported }
formenctypeApplicationXWwwFormUrlencoded =
    Ir.token "application/x-www-form-urlencoded"


{-| The `multipart/form-data` value of the `formenctype` enum — same open row as `multipartFormData`, prefixed for discovery.
-}
formenctypeMultipartFormData : Value { v | multipartFormData : Supported }
formenctypeMultipartFormData =
    Ir.token "multipart/form-data"


{-| The `text/plain` value of the `formenctype` enum — same open row as `textPlain`, prefixed for discovery.
-}
formenctypeTextPlain : Value { v | textPlain : Supported }
formenctypeTextPlain =
    Ir.token "text/plain"


{-| The `dialog` value of the `formmethod` enum — same open row as `dialog`, prefixed for discovery.
-}
formmethodDialog : Value { v | dialog : Supported }
formmethodDialog =
    Ir.token "dialog"


{-| The `get` value of the `formmethod` enum — same open row as `get`, prefixed for discovery.
-}
formmethodGet : Value { v | get : Supported }
formmethodGet =
    Ir.token "get"


{-| The `post` value of the `formmethod` enum — same open row as `post`, prefixed for discovery.
-}
formmethodPost : Value { v | post : Supported }
formmethodPost =
    Ir.token "post"


{-| The `content-security-policy` value of the `httpEquiv` enum — same open row as `contentSecurityPolicy`, prefixed for discovery.
-}
httpEquivContentSecurityPolicy : Value { v | contentSecurityPolicy : Supported }
httpEquivContentSecurityPolicy =
    Ir.token "content-security-policy"


{-| The `content-type` value of the `httpEquiv` enum — same open row as `contentType`, prefixed for discovery.
-}
httpEquivContentType : Value { v | contentType : Supported }
httpEquivContentType =
    Ir.token "content-type"


{-| The `default-style` value of the `httpEquiv` enum — same open row as `defaultStyle`, prefixed for discovery.
-}
httpEquivDefaultStyle : Value { v | defaultStyle : Supported }
httpEquivDefaultStyle =
    Ir.token "default-style"


{-| The `refresh` value of the `httpEquiv` enum — same open row as `refresh`, prefixed for discovery.
-}
httpEquivRefresh : Value { v | refresh : Supported }
httpEquivRefresh =
    Ir.token "refresh"


{-| The `x-ua-compatible` value of the `httpEquiv` enum — same open row as `xUaCompatible`, prefixed for discovery.
-}
httpEquivXUaCompatible : Value { v | xUaCompatible : Supported }
httpEquivXUaCompatible =
    Ir.token "x-ua-compatible"


{-| The `captions` value of the `kind` enum — same open row as `captions`, prefixed for discovery.
-}
kindCaptions : Value { v | captions : Supported }
kindCaptions =
    Ir.token "captions"


{-| The `chapters` value of the `kind` enum — same open row as `chapters`, prefixed for discovery.
-}
kindChapters : Value { v | chapters : Supported }
kindChapters =
    Ir.token "chapters"


{-| The `descriptions` value of the `kind` enum — same open row as `descriptions`, prefixed for discovery.
-}
kindDescriptions : Value { v | descriptions : Supported }
kindDescriptions =
    Ir.token "descriptions"


{-| The `metadata` value of the `kind` enum — same open row as `metadata`, prefixed for discovery.
-}
kindMetadata : Value { v | metadata : Supported }
kindMetadata =
    Ir.token "metadata"


{-| The `subtitles` value of the `kind` enum — same open row as `subtitles`, prefixed for discovery.
-}
kindSubtitles : Value { v | subtitles : Supported }
kindSubtitles =
    Ir.token "subtitles"


{-| The `eager` value of the `loading` enum — same open row as `eager`, prefixed for discovery.
-}
loadingEager : Value { v | eager : Supported }
loadingEager =
    Ir.token "eager"


{-| The `lazy` value of the `loading` enum — same open row as `lazy`, prefixed for discovery.
-}
loadingLazy : Value { v | lazy : Supported }
loadingLazy =
    Ir.token "lazy"


{-| The `dialog` value of the `method` enum — same open row as `dialog`, prefixed for discovery.
-}
methodDialog : Value { v | dialog : Supported }
methodDialog =
    Ir.token "dialog"


{-| The `get` value of the `method` enum — same open row as `get`, prefixed for discovery.
-}
methodGet : Value { v | get : Supported }
methodGet =
    Ir.token "get"


{-| The `post` value of the `method` enum — same open row as `post`, prefixed for discovery.
-}
methodPost : Value { v | post : Supported }
methodPost =
    Ir.token "post"


{-| The `hide` value of the `popovertargetaction` enum — same open row as `hide`, prefixed for discovery.
-}
popovertargetactionHide : Value { v | hide : Supported }
popovertargetactionHide =
    Ir.token "hide"


{-| The `show` value of the `popovertargetaction` enum — same open row as `show`, prefixed for discovery.
-}
popovertargetactionShow : Value { v | show : Supported }
popovertargetactionShow =
    Ir.token "show"


{-| The `toggle` value of the `popovertargetaction` enum — same open row as `toggle`, prefixed for discovery.
-}
popovertargetactionToggle : Value { v | toggle : Supported }
popovertargetactionToggle =
    Ir.token "toggle"


{-| The \``value of the`preload`enum — same open row as`value\`, prefixed for discovery.
-}
preloadValue : Value { v | value : Supported }
preloadValue =
    Ir.token ""


{-| The `auto` value of the `preload` enum — same open row as `auto`, prefixed for discovery.
-}
preloadAuto : Value { v | auto : Supported }
preloadAuto =
    Ir.token "auto"


{-| The `metadata` value of the `preload` enum — same open row as `metadata`, prefixed for discovery.
-}
preloadMetadata : Value { v | metadata : Supported }
preloadMetadata =
    Ir.token "metadata"


{-| The `none` value of the `preload` enum — same open row as `none`, prefixed for discovery.
-}
preloadNone : Value { v | none : Supported }
preloadNone =
    Ir.token "none"


{-| The \``value of the`referrerpolicy`enum — same open row as`value\`, prefixed for discovery.
-}
referrerpolicyValue : Value { v | value : Supported }
referrerpolicyValue =
    Ir.token ""


{-| The `no-referrer` value of the `referrerpolicy` enum — same open row as `noReferrer`, prefixed for discovery.
-}
referrerpolicyNoReferrer : Value { v | noReferrer : Supported }
referrerpolicyNoReferrer =
    Ir.token "no-referrer"


{-| The `no-referrer-when-downgrade` value of the `referrerpolicy` enum — same open row as `noReferrerWhenDowngrade`, prefixed for discovery.
-}
referrerpolicyNoReferrerWhenDowngrade : Value { v | noReferrerWhenDowngrade : Supported }
referrerpolicyNoReferrerWhenDowngrade =
    Ir.token "no-referrer-when-downgrade"


{-| The `origin` value of the `referrerpolicy` enum — same open row as `origin`, prefixed for discovery.
-}
referrerpolicyOrigin : Value { v | origin : Supported }
referrerpolicyOrigin =
    Ir.token "origin"


{-| The `origin-when-cross-origin` value of the `referrerpolicy` enum — same open row as `originWhenCrossOrigin`, prefixed for discovery.
-}
referrerpolicyOriginWhenCrossOrigin : Value { v | originWhenCrossOrigin : Supported }
referrerpolicyOriginWhenCrossOrigin =
    Ir.token "origin-when-cross-origin"


{-| The `same-origin` value of the `referrerpolicy` enum — same open row as `sameOrigin`, prefixed for discovery.
-}
referrerpolicySameOrigin : Value { v | sameOrigin : Supported }
referrerpolicySameOrigin =
    Ir.token "same-origin"


{-| The `strict-origin` value of the `referrerpolicy` enum — same open row as `strictOrigin`, prefixed for discovery.
-}
referrerpolicyStrictOrigin : Value { v | strictOrigin : Supported }
referrerpolicyStrictOrigin =
    Ir.token "strict-origin"


{-| The `strict-origin-when-cross-origin` value of the `referrerpolicy` enum — same open row as `strictOriginWhenCrossOrigin`, prefixed for discovery.
-}
referrerpolicyStrictOriginWhenCrossOrigin : Value { v | strictOriginWhenCrossOrigin : Supported }
referrerpolicyStrictOriginWhenCrossOrigin =
    Ir.token "strict-origin-when-cross-origin"


{-| The `unsafe-url` value of the `referrerpolicy` enum — same open row as `unsafeUrl`, prefixed for discovery.
-}
referrerpolicyUnsafeUrl : Value { v | unsafeUrl : Supported }
referrerpolicyUnsafeUrl =
    Ir.token "unsafe-url"


{-| The `allow-downloads` value of the `sandbox` enum — same open row as `allowDownloads`, prefixed for discovery.
-}
sandboxAllowDownloads : Value { v | allowDownloads : Supported }
sandboxAllowDownloads =
    Ir.token "allow-downloads"


{-| The `allow-forms` value of the `sandbox` enum — same open row as `allowForms`, prefixed for discovery.
-}
sandboxAllowForms : Value { v | allowForms : Supported }
sandboxAllowForms =
    Ir.token "allow-forms"


{-| The `allow-modals` value of the `sandbox` enum — same open row as `allowModals`, prefixed for discovery.
-}
sandboxAllowModals : Value { v | allowModals : Supported }
sandboxAllowModals =
    Ir.token "allow-modals"


{-| The `allow-orientation-lock` value of the `sandbox` enum — same open row as `allowOrientationLock`, prefixed for discovery.
-}
sandboxAllowOrientationLock : Value { v | allowOrientationLock : Supported }
sandboxAllowOrientationLock =
    Ir.token "allow-orientation-lock"


{-| The `allow-pointer-lock` value of the `sandbox` enum — same open row as `allowPointerLock`, prefixed for discovery.
-}
sandboxAllowPointerLock : Value { v | allowPointerLock : Supported }
sandboxAllowPointerLock =
    Ir.token "allow-pointer-lock"


{-| The `allow-popups` value of the `sandbox` enum — same open row as `allowPopups`, prefixed for discovery.
-}
sandboxAllowPopups : Value { v | allowPopups : Supported }
sandboxAllowPopups =
    Ir.token "allow-popups"


{-| The `allow-popups-to-escape-sandbox` value of the `sandbox` enum — same open row as `allowPopupsToEscapeSandbox`, prefixed for discovery.
-}
sandboxAllowPopupsToEscapeSandbox : Value { v | allowPopupsToEscapeSandbox : Supported }
sandboxAllowPopupsToEscapeSandbox =
    Ir.token "allow-popups-to-escape-sandbox"


{-| The `allow-presentation` value of the `sandbox` enum — same open row as `allowPresentation`, prefixed for discovery.
-}
sandboxAllowPresentation : Value { v | allowPresentation : Supported }
sandboxAllowPresentation =
    Ir.token "allow-presentation"


{-| The `allow-same-origin` value of the `sandbox` enum — same open row as `allowSameOrigin`, prefixed for discovery.
-}
sandboxAllowSameOrigin : Value { v | allowSameOrigin : Supported }
sandboxAllowSameOrigin =
    Ir.token "allow-same-origin"


{-| The `allow-scripts` value of the `sandbox` enum — same open row as `allowScripts`, prefixed for discovery.
-}
sandboxAllowScripts : Value { v | allowScripts : Supported }
sandboxAllowScripts =
    Ir.token "allow-scripts"


{-| The `allow-top-navigation` value of the `sandbox` enum — same open row as `allowTopNavigation`, prefixed for discovery.
-}
sandboxAllowTopNavigation : Value { v | allowTopNavigation : Supported }
sandboxAllowTopNavigation =
    Ir.token "allow-top-navigation"


{-| The `allow-top-navigation-by-user-activation` value of the `sandbox` enum — same open row as `allowTopNavigationByUserActivation`, prefixed for discovery.
-}
sandboxAllowTopNavigationByUserActivation : Value { v | allowTopNavigationByUserActivation : Supported }
sandboxAllowTopNavigationByUserActivation =
    Ir.token "allow-top-navigation-by-user-activation"


{-| The `allow-top-navigation-to-custom-protocols` value of the `sandbox` enum — same open row as `allowTopNavigationToCustomProtocols`, prefixed for discovery.
-}
sandboxAllowTopNavigationToCustomProtocols : Value { v | allowTopNavigationToCustomProtocols : Supported }
sandboxAllowTopNavigationToCustomProtocols =
    Ir.token "allow-top-navigation-to-custom-protocols"


{-| The `col` value of the `scope` enum — same open row as `col`, prefixed for discovery.
-}
scopeCol : Value { v | col : Supported }
scopeCol =
    Ir.token "col"


{-| The `colgroup` value of the `scope` enum — same open row as `colgroup`, prefixed for discovery.
-}
scopeColgroup : Value { v | colgroup : Supported }
scopeColgroup =
    Ir.token "colgroup"


{-| The `row` value of the `scope` enum — same open row as `row`, prefixed for discovery.
-}
scopeRow : Value { v | row : Supported }
scopeRow =
    Ir.token "row"


{-| The `rowgroup` value of the `scope` enum — same open row as `rowgroup`, prefixed for discovery.
-}
scopeRowgroup : Value { v | rowgroup : Supported }
scopeRowgroup =
    Ir.token "rowgroup"


{-| The `closed` value of the `shadowrootmode` enum — same open row as `closed`, prefixed for discovery.
-}
shadowrootmodeClosed : Value { v | closed : Supported }
shadowrootmodeClosed =
    Ir.token "closed"


{-| The `open` value of the `shadowrootmode` enum — same open row as `open`, prefixed for discovery.
-}
shadowrootmodeOpen : Value { v | open : Supported }
shadowrootmodeOpen =
    Ir.token "open"


{-| The `manual` value of the `shadowrootslotassignment` enum — same open row as `manual`, prefixed for discovery.
-}
shadowrootslotassignmentManual : Value { v | manual : Supported }
shadowrootslotassignmentManual =
    Ir.token "manual"


{-| The `named` value of the `shadowrootslotassignment` enum — same open row as `named`, prefixed for discovery.
-}
shadowrootslotassignmentNamed : Value { v | named : Supported }
shadowrootslotassignmentNamed =
    Ir.token "named"


{-| The `circle` value of the `shape` enum — same open row as `circle`, prefixed for discovery.
-}
shapeCircle : Value { v | circle : Supported }
shapeCircle =
    Ir.token "circle"


{-| The `default` value of the `shape` enum — same open row as `default`, prefixed for discovery.
-}
shapeDefault : Value { v | default : Supported }
shapeDefault =
    Ir.token "default"


{-| The `poly` value of the `shape` enum — same open row as `poly`, prefixed for discovery.
-}
shapePoly : Value { v | poly : Supported }
shapePoly =
    Ir.token "poly"


{-| The `rect` value of the `shape` enum — same open row as `rect`, prefixed for discovery.
-}
shapeRect : Value { v | rect : Supported }
shapeRect =
    Ir.token "rect"


{-| The `hard` value of the `wrap` enum — same open row as `hard`, prefixed for discovery.
-}
wrapHard : Value { v | hard : Supported }
wrapHard =
    Ir.token "hard"


{-| The `soft` value of the `wrap` enum — same open row as `soft`, prefixed for discovery.
-}
wrapSoft : Value { v | soft : Supported }
wrapSoft =
    Ir.token "soft"
