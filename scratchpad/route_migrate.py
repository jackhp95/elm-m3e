# Reusable SAFE cookbook transforms (no Card structural split — do those by hand).
import re
def migrate_common(s):
    # imports
    if 'import EscapeHatch' not in s:
        s=s.replace('import M3e.Divider','import EscapeHatch\nimport Kit\nimport M3e.Divider',1) if 'import M3e.Divider' in s else s.replace('import M3e.Element','import EscapeHatch\nimport Kit\nimport M3e.Element',1)
    s=s.replace('import M3e.Element as Element\n','import M3e.Element as Element exposing (Element)\n')
    s=s.replace('import M3e.Value as Value\n','import M3e.Value as Value exposing (Supported)\n')
    # Node.element "X" -> Native.node (Html.node "X"); add Native/Seam
    if re.search(r'Node\.element ',s):
        s=re.sub(r'Node\.element (\"[^\"]+\")', r'Native.node (Html.node \1)', s)
        if 'import Native' not in s: s=s.replace('import M3e.Node','import Native\nimport M3e.Node',1)
    if 'Node.rawAttr' in s:
        s=s.replace('Node.rawAttr','Seam.asAttribute')
        if 'import Seam' not in s: s=s.replace('import Shared','import Seam\nimport Shared',1)
    # leaf conversions
    s=s.replace('Node.text','Kit.text')
    s=s.replace('Node.raw','EscapeHatch.fromHtml')
    s=s.replace('Element.html','EscapeHatch.fromHtml')
    s=s.replace('Heading.level 1','Heading.level "1"').replace('Heading.level 2','Heading.level "2"').replace('Heading.level 3','Heading.level "3"')
    s=s.replace('Card.headline','Card.header')
    s=re.sub(r'Divider\.view \[\]([^\]])', r'Divider.view [] []\1', s)  # only bare []
    s=s.replace('Divider.view []\n','Divider.view [] []\n')
    # drop inner toNode
    s=s.replace(' |> Element.toNode','')
    # annotations Node msg -> open element row is per-file; leave for caller
    return s

# Generic Heading record->content transform (safe subset). Card two-list splits and
# component-specific calls (Button/Icon/Avatar/Shape) still need per-file hand-fixing.
import re as _re
def fix_headings(s):
    def _h(m):
        label,variant,ind,attrs=m.group(1),m.group(2),m.group(3),m.group(4)
        return f'Heading.view {{ content = Kit.text {label} }}\n{ind}[ Heading.variant {variant}, {attrs} ]\n{ind}[]'
    s=_re.sub(r'Heading\.view \{ label = (.+?), variant = (.+?) \}\n(\s+)\[ (Heading\.[^\]]+?) \]', _h, s)
    s=_re.sub(r'Heading\.view \{ label = (.+?), variant = (.+?) \} \[\]', r'Heading.view { content = Kit.text \1 } [ Heading.variant \2 ] []', s)
    return s
# Usage: from route_migrate import migrate_common, fix_headings
#   s = fix_headings(migrate_common(open(f).read()))
#   then hand-fix Card blocks ([attrs][content], headline->header, body[list]->content(el),
#   drop Element.fromNode around Layout.*), add open-row annotations, and wrap the
#   View.body with `List.map Element.toNode [ ... ]`. Compile after each file.
