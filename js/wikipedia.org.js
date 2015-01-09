// Replace all SVGs that are rendered as PNGs with the original SVG file.
var imgs = [].slice.apply(document.getElementsByTagName('img'))
imgs.forEach(function(img) {
  img.src = img.src.replace(/\/thumb(\/.+)\/\d+px-.+\.svg\.png.*$/, '$1')
  img.removeAttribute('srcset')
})
