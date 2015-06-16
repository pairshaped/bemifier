var Bemmer;

Bemmer = (function() {
  Bemmer._compact = function(arr) {
    var i, item, len, newArray;
    if (typeof _ === 'function' && _) {
      return _.compact(arr);
    }
    newArray = [];
    for (i = 0, len = arr.length; i < len; i++) {
      item = arr[i];
      if (!(item === void 0 || item === null)) {
        newArray.push(item);
      }
    }
    return newArray;
  };

  Bemmer.prefixes = {
    blockElement: '__',
    elementModifier: '--',
    nameSpacing: '-'
  };

  function Bemmer(bemHash) {
    this.bemHash = bemHash;
    if (!this.bemHash.block) {
      throw new Error("Bemmer needs an object with a 'block' key to make css classes.");
    }
  }

  Bemmer.prototype.classes = function() {
    return Bemmer.className(this.bemHash);
  };

  Bemmer.prototype.elementFromBlock = function(bemObject) {
    var object;
    object = bemObject;
    bemObject.block = this.bemObject.block;
    return new Bemmer(bmObject);
  };

  Bemmer.prototype["with"] = function(bemObject) {
    return this.elementFromBlock(bemObject).classes();
  };

  Bemmer.bemName = function(name) {
    if (name instanceof Array) {
      return name.join(Bemmer.prefixes.nameSpacing);
    } else {
      return name;
    }
  };

  Bemmer.bemModifier = function(modifier, value) {
    if (!!value === value) {
      if (value) {
        return modifier;
      }
    } else {
      return Bemmer.bemName([modifier, value]);
    }
  };

  Bemmer.mapModifiers = function(modifiers, blockElement) {
    var classes, element, key, m, value;
    modifiers = modifiers || {};
    classes = [];
    for (key in modifiers) {
      value = modifiers[key];
      m = this.bemModifier(key, value);
      element = this._compact([blockElement, m]).join(Bemmer.prefixes.elementModifier);
      classes.push(element);
    }
    return classes;
  };

  Bemmer.className = function(bemObject) {
    var block, blockElement, classes, element;
    block = Bemmer.bemName(bemObject.block);
    element = Bemmer.bemName(bemObject.element);
    classes = [];
    if (bemObject.classNames) {
      classes = [bemObject.classNames];
    }
    blockElement = Bemmer._compact([block, element]).join(Bemmer.prefixes.blockElement);
    classes.push(blockElement);
    classes = classes.concat(Bemmer.mapModifiers(bemObject.modifiers, blockElement));
    return classes.join(' ');
  };

  return Bemmer;

})();

if (typeof define === 'function' && typeof define.amd === 'object' && define.amd) {
  define(function() {
    return Bemmer;
  });
} else if (typeof module !== 'undefined' && module.exports) {
  module.exports = Bemmer;
} else {
  window.Bemmer = Bemmer;
}
