var compiler = require("@glimmer/compiler");

function getTemplateSpecifier(rootName, absolutePath) {
  var path = absolutePath.split('/').slice(-4);
  var prefix = path.shift();

  // TODO - should use module map config to be rigorous
  if (path[path.length - 1] === 'template.hbs') {
      path.pop();
  }
  if (path[0] === 'ui') {
      path.shift();
  }
  return 'template:/' + rootName + '/' + path.join('/');
};

module.exports = function(source) {
  var specifier = getTemplateSpecifier("messages-app", this.resourcePath);

  return 'export default ' + (0, compiler.precompile)(source, { meta: { specifier: specifier, '<template-meta>': true } }) + ';';
};
