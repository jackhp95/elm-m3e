// <raw-html content="..."> — injects its `content` attribute as innerHTML so the
// embedded <m3e-*> custom elements upgrade in place. Used by the docs Usage
// previews (Doc.rawPreview). Elm can't set innerHTML via a property under
// elm-pages hydration, so a custom element owns its own subtree instead.
class RawHtml extends HTMLElement {
  static get observedAttributes() {
    return ["content"];
  }
  connectedCallback() {
    this.render();
  }
  attributeChangedCallback() {
    if (this.isConnected) this.render();
  }
  render() {
    const next = this.getAttribute("content") || "";
    if (this._last !== next) {
      this._last = next;
      this.innerHTML = next;
    }
  }
}
if (!customElements.get("raw-html")) customElements.define("raw-html", RawHtml);
