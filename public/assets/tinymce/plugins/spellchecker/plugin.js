!function(e,t){"use strict";function n(e,t){for(var n,r=[],i=0;i<e.length;++i){if(n=s[e[i]]||o(e[i]),!n)throw"module definition dependecy not found: "+e[i];r.push(n)}t.apply(null,r)}function r(e,r,i){if("string"!=typeof e)throw"invalid module definition, module id must be defined and be a string";if(r===t)throw"invalid module definition, dependencies must be specified";if(i===t)throw"invalid module definition, definition function must be specified";n(r,function(){s[e]=i.apply(null,arguments)})}function i(e){return!!s[e]}function o(t){for(var n=e,r=t.split(/[.\/]/),i=0;i<r.length;++i){if(!n[r[i]])return;n=n[r[i]]}return n}function a(n){for(var r=0;r<n.length;r++){for(var i=e,o=n[r],a=o.split(/[.\/]/),l=0;l<a.length-1;++l)i[a[l]]===t&&(i[a[l]]={}),i=i[a[l]];i[a[a.length-1]]=s[o]}}var s={},l="tinymce/spellcheckerplugin/DomTextMatcher",c="tinymce/spellcheckerplugin/Plugin",d="tinymce/PluginManager",u="tinymce/util/Tools",f="tinymce/ui/Menu",p="tinymce/dom/DOMUtils",h="tinymce/util/JSONRequest",m="tinymce/util/URI";r(l,[],function(){return function(e,t,n){function r(e){if(!e[0])throw"findAndReplaceDOMText cannot handle zero-length matches";var t=e.index;return[t,t+e[0].length,[e[0]]]}function i(e){var t;if(3===e.nodeType)return e.data;if(g[e.nodeName])return"";if(t="",(m[e.nodeName]||v[e.nodeName])&&(t+="\n"),e=e.firstChild)do t+=i(e);while(e=e.nextSibling);return t}function o(e,t,n){var r,i,o,a,s=[],l=0,c=e,d=t.shift(),u=0;e:for(;;){if((m[c.nodeName]||v[c.nodeName])&&l++,3===c.nodeType&&(!i&&c.length+l>=d[1]?(i=c,a=d[1]-l):r&&s.push(c),!r&&c.length+l>d[0]&&(r=c,o=d[0]-l),l+=c.length),r&&i){if(c=n({startNode:r,startNodeIndex:o,endNode:i,endNodeIndex:a,innerNodes:s,match:d[2],matchIndex:u}),l-=i.length-a,r=null,i=null,s=[],d=t.shift(),u++,!d)break}else{if(!g[c.nodeName]&&c.firstChild){c=c.firstChild;continue}if(c.nextSibling){c=c.nextSibling;continue}}for(;;){if(c.nextSibling){c=c.nextSibling;break}if(c.parentNode===e)break e;c=c.parentNode}}}function a(e){var t;if("function"!=typeof e){var n=e.nodeType?e:h.createElement(e);t=function(e,t){var r=n.cloneNode(!1);return r.setAttribute("data-mce-index",t),e&&r.appendChild(h.createTextNode(e)),r}}else t=e;return function r(e){var n,r,i,o=e.startNode,a=e.endNode,s=e.matchIndex;if(o===a){var l=o;i=l.parentNode,e.startNodeIndex>0&&(n=h.createTextNode(l.data.substring(0,e.startNodeIndex)),i.insertBefore(n,l));var c=t(e.match[0],s);return i.insertBefore(c,l),e.endNodeIndex<l.length&&(r=h.createTextNode(l.data.substring(e.endNodeIndex)),i.insertBefore(r,l)),l.parentNode.removeChild(l),c}n=h.createTextNode(o.data.substring(0,e.startNodeIndex)),r=h.createTextNode(a.data.substring(e.endNodeIndex));for(var d=t(o.data.substring(e.startNodeIndex),s),u=[],f=0,p=e.innerNodes.length;p>f;++f){var m=e.innerNodes[f],g=t(m.data,s);m.parentNode.replaceChild(g,m),u.push(g)}var v=t(a.data.substring(0,e.endNodeIndex),s);return i=o.parentNode,i.insertBefore(n,o),i.insertBefore(d,o),i.removeChild(o),i=a.parentNode,i.insertBefore(v,a),i.insertBefore(r,a),i.removeChild(a),v}}function s(e){var t=[];return l(function(n,r){e(n,r)&&t.push(n)}),u=t,this}function l(e){for(var t=0,n=u.length;n>t&&e(u[t],t)!==!1;t++);return this}function c(e){return u.length&&(p=u.length,o(t,u,a(e))),this}var d,u=[],f,p=0,h,m,g,v;if(h=t.ownerDocument,m=n.getBlockElements(),g=n.getWhiteSpaceElements(),v=n.getShortEndedElements(),f=i(t),f&&e.global)for(;d=e.exec(f);)u.push(r(d));return{text:f,count:p,matches:u,each:l,filter:s,mark:c}}}),r(c,[l,d,u,f,p,h,m],function(e,t,n,r,i,o,a){t.add("spellchecker",function(t,s){function l(e){for(var t in e)return!1;return!0}function c(e,o){var a=[],s=g[o];n.each(s,function(e){a.push({text:e,onclick:function(){t.insertContent(e),u()}})}),a.push.apply(a,[{text:"-"},{text:"Ignore",onclick:function(){p(e,o)}},{text:"Ignore all",onclick:function(){p(e,o,!0)}},{text:"Finish",onclick:h}]),y=new r({items:a,context:"contextmenu",onautohide:function(e){-1!=e.target.className.indexOf("spellchecker")&&e.preventDefault()},onhide:function(){y.remove(),y=null}}),y.renderTo(document.body);var l=i.DOM.getPos(t.getContentAreaContainer()),c=t.dom.getPos(e);l.x+=c.x,l.y+=c.y,y.moveTo(l.x,l.y+e.offsetHeight)}function d(){function n(e){return t.setProgressState(!1),l(e)?(t.windowManager.alert("No misspellings found"),v=!1,void 0):(g=e,i.filter(function(t){return!!e[t[2][0]]}).mark(t.dom.create("span",{"class":"mce-spellchecker-word","data-mce-bogus":1})),i=null,t.fire("SpellcheckStart"),void 0)}function r(e,n,r){o.sendRPC({url:new a(s).toAbsolute(b.spellchecker_rpc_url),method:e,params:{lang:b.spellchecker_language||"en",words:n},success:function(e){r(e)},error:function(e,n){e="JSON Parse error."==e?"Non JSON response:"+n.responseText:"Error: "+e,t.windowManager.alert(e),t.setProgressState(!1),i=null,v=!1}})}var i,c=[],d={};if(v)return h(),void 0;v=!0;var u=t.getParam("spellchecker_wordchar_pattern")||new RegExp('[^\\s!"#$%&()*+,-./:;<=>?@[\\]^_{|}`\xa7\xa9\xab\xae\xb1\xb6\xb7\xb8\xbb\xbc\xbd\xbe\xbf\xd7\xf7\xa4\u201d\u201c\u201e]+',"g");i=new e(u,t.getBody(),t.schema).each(function(e){var t=e[2][0];if(!d[t]){if(/^\d+$/.test(t)||1==t.length)return;c.push(t),d[t]=!0}}),t.setProgressState(!0);var f=b.spellchecker_callback||r;f("spellcheck",c,n)}function u(){t.dom.select("span.mce-spellchecker-word").length||h()}function f(e){var t=e.parentNode;t.insertBefore(e.firstChild,e),e.parentNode.removeChild(e)}function p(e,r,i){i?n.each(t.dom.select("span.mce-spellchecker-word"),function(e){var t=e.innerText||e.textContent;t==r&&f(e)}):f(e),u()}function h(){var e,n,r;for(v=!1,r=t.getBody(),n=r.getElementsByTagName("span"),e=n.length;e--;)r=n[e],r.getAttribute("data-mce-index")&&f(r);t.fire("SpellcheckEnd")}function m(e){var n,r,i,o=-1,a,s;for(e=""+e,n=t.getBody().getElementsByTagName("span"),r=0;r<n.length&&(i=n[r],"mce-spellchecker-word"!=i.className||(o=i.getAttribute("data-mce-index"),o===e&&(o=e,a||(a=i.firstChild),s=i.firstChild),o===e||!s));r++);var l=t.dom.createRng();return l.setStart(a,0),l.setEnd(s,s.length),t.selection.setRng(l),l}var g,v,y,b=t.settings;t.on("click",function(e){if("mce-spellchecker-word"==e.target.className){e.preventDefault();var t=m(e.target.getAttribute("data-mce-index"));c(e.target,t.toString())}}),t.addMenuItem("spellchecker",{text:"Spellcheck",context:"tools",onclick:d,selectable:!0,onPostRender:function(){var e=this;t.on("SpellcheckStart SpellcheckEnd",function(){e.active(v)})}}),t.addButton("spellchecker",{tooltip:"Spellcheck",onclick:d,onPostRender:function(){var e=this;t.on("SpellcheckStart SpellcheckEnd",function(){e.active(v)})}}),t.on("remove",function(){y&&(y.remove(),y=null)})})}),a([l,c])}(this);