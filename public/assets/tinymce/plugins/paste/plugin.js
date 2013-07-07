!function(e,t){"use strict";function n(e,t){for(var n,r=[],i=0;i<e.length;++i){if(n=s[e[i]]||o(e[i]),!n)throw"module definition dependecy not found: "+e[i];r.push(n)}t.apply(null,r)}function r(e,r,i){if("string"!=typeof e)throw"invalid module definition, module id must be defined and be a string";if(r===t)throw"invalid module definition, dependencies must be specified";if(i===t)throw"invalid module definition, definition function must be specified";n(r,function(){s[e]=i.apply(null,arguments)})}function i(e){return!!s[e]}function o(t){for(var n=e,r=t.split(/[.\/]/),i=0;i<r.length;++i){if(!n[r[i]])return;n=n[r[i]]}return n}function a(n){for(var r=0;r<n.length;r++){for(var i=e,o=n[r],a=o.split(/[.\/]/),l=0;l<a.length-1;++l)i[a[l]]===t&&(i[a[l]]={}),i=i[a[l]];i[a[a.length-1]]=s[o]}}var s={},l="tinymce/pasteplugin/Clipboard",c="tinymce/Env",d="tinymce/util/Tools",u="tinymce/util/VK",f="tinymce/pasteplugin/WordFilter",p="tinymce/html/DomParser",m="tinymce/html/Schema",h="tinymce/html/Serializer",g="tinymce/html/Node",v="tinymce/pasteplugin/Quirks",y="tinymce/pasteplugin/Plugin",b="tinymce/PluginManager";r(l,[c,d,u],function(e,t,n){function r(){return!e.gecko&&("ClipboardEvent"in window||e.webkit&&"FocusEvent"in window)}return function(i){function o(){return(new Date).getTime()}function a(e){return n.metaKeyPressed(e)&&86==e.keyCode||e.shiftKey&&45==e.keyCode}function s(e){return e.innerText||e.textContent}function l(){return o()-h<100||"text"==m.pasteFormat}function c(e,n){return t.each(n,function(t){e=t.constructor==RegExp?e.replace(t,""):e.replace(t[0],t[1])}),e}function d(t){var n=i.fire("PastePreProcess",{content:t});t=n.content,i.settings.paste_data_images||(t=t.replace(/<img src=\"data:image[^>]+>/g,"")),(i.settings.paste_remove_styles||i.settings.paste_remove_styles_if_webkit!==!1&&e.webkit)&&(t=t.replace(/ style=\"[^\"]+\"/g,"")),n.isDefaultPrevented()||i.insertContent(t)}function u(e){e=i.dom.encode(e).replace(/\r\n/g,"\n");var t=i.dom.getParent(i.selection.getStart(),i.dom.isBlock);e=t&&/^(PRE|DIV)$/.test(t.nodeName)||!i.settings.forced_root_block?c(e,[[/\n/g,"<br>"]]):c(e,[[/\n\n/g,"</p><p>"],[/^(.*<\/p>)(<p>)$/,"<p>$1"],[/\n/g,"<br />"]]);var n=i.fire("PastePreProcess",{content:e});n.isDefaultPrevented()||i.insertContent(n.content)}function f(){var e=i.dom.getViewPort().y,t=i.dom.add(i.getBody(),"div",{contentEditable:!1,"data-mce-bogus":"1",style:"position: absolute; top: "+e+"px; left: 0; width: 1px; height: 1px; overflow: hidden"},'<div contentEditable="true" data-mce-bogus="1">X</div>');return i.dom.bind(t,"beforedeactivate focusin focusout",function(e){e.stopPropagation()}),t}function p(e){i.dom.unbind(e),i.dom.remove(e)}var m=this,h;i.on("keydown",function(e){n.metaKeyPressed(e)&&e.shiftKey&&86==e.keyCode&&(h=o())}),r()?i.on("paste",function(e){function t(e,t){for(var r=0;r<n.types.length;r++)if(n.types[r]==e)return t(n.getData(e)),!0}var n=e.clipboardData;n&&(e.preventDefault(),l()?t("text/plain",u)||t("text/html",d):t("text/html",d)||t("text/plain",u))}):(e.ie?i.on("init",function(){var e=i.dom,t=0;i.on("keydown",function(n){if(a(n)&&!n.isDefaultPrevented()){var r=f();t=o(),e.bind(r,"paste",function(){setTimeout(function(){p(r),i.selection.setRng(c),l()?u(s(r.firstChild)):d(r.firstChild.innerHTML)},0)});var c=i.selection.getRng();r.firstChild.focus(),r.firstChild.innerText=""}}),i.dom.bind(i.getBody(),"paste",function(n){if(o()-t>100){var r,a=f();n.preventDefault(),e.bind(a,"paste",function(e){e.stopPropagation(),r=!0});var c=i.selection.getRng(),m=e.doc.body.createTextRange();if(m.moveToElementText(a.firstChild),m.execCommand("Paste"),p(a),!r)return i.windowManager.alert("Please use Ctrl+V/Cmd+V keyboard shortcuts to paste contents."),void 0;i.selection.setRng(c),l()?u(s(a.firstChild)):d(a.firstChild.innerHTML)}})}):(i.on("init",function(){i.dom.bind(i.getBody(),"paste",function(e){e.preventDefault(),i.windowManager.alert("Please use Ctrl+V/Cmd+V keyboard shortcuts to paste contents.")})}),i.on("keydown",function(e){if(a(e)&&!e.isDefaultPrevented()){var t=f(),n=i.selection.getRng();i.selection.select(t,!0),i.dom.bind(t,"paste",function(e){e.stopPropagation(),setTimeout(function(){p(t),i.lastRng=n,i.selection.setRng(n);var e=t.firstChild;e.lastChild&&"BR"==e.lastChild.nodeName&&e.removeChild(e.lastChild),l()?u(s(e)):d(e.innerHTML)},0)})}})),i.settings.paste_data_images||i.on("drop",function(e){var t=e.dataTransfer;t&&t.files&&t.files.length>0&&e.preventDefault()})),i.paste_block_drop&&i.on("dragend dragover draggesture dragdrop drop drag",function(e){e.preventDefault(),e.stopPropagation()}),this.paste=d,this.pasteText=u}}),r(f,[d,p,m,h,g],function(e,t,n,r,i){return function(o){var a=e.each;o.on("PastePreProcess",function(s){function l(e){a(e,function(e){u=e.constructor==RegExp?u.replace(e,""):u.replace(e[0],e[1])})}function c(e){function t(e,t,a,s){var l=e._listLevel||o;l!=o&&(o>l?n&&(n=n.parent.parent):(r=n,n=null)),n&&n.name==a?n.append(e):(r=r||n,n=new i(a,1),s>1&&n.attr("start",""+s),e.wrap(n)),e.name="li",t.value="";var c=t.next;c&&3==c.type&&(c.value=c.value.replace(/^\u00a0+/,"")),l>o&&r.lastChild.append(n),o=l}for(var n,r,o=1,a=e.getAll("p"),s=0;s<a.length;s++)if(e=a[s],"p"==e.name&&e.firstChild){for(var l="",c=e.firstChild;c&&!(l=c.value);)c=c.firstChild;if(/^\s*[\u2022\u00b7\u00a7\u00d8o\u25CF]\s*$/.test(l)){t(e,c,"ul");continue}if(/^\s*\w+\./.test(l)){var d=/([0-9])\./.exec(l),u=1;d&&(u=parseInt(d[1],10)),t(e,c,"ol",u);continue}n=null}}function d(t,n){if("p"===t.name){var r=/mso-list:\w+ \w+([0-9]+)/.exec(n);r&&(t._listLevel=parseInt(r[1],10))}if(o.getParam("paste_retain_style_properties","none")){var i="";if(e.each(o.dom.parseStyle(n),function(e,t){switch(t){case"horiz-align":return t="text-align",void 0;case"vert-align":return t="vertical-align",void 0;case"font-color":case"mso-foreground":return t="color",void 0;case"mso-background":case"mso-highlight":t="background"}("all"==f||p&&p[t])&&(i+=t+":"+e+";")}),i)return i}return null}var u=s.content,f,p;if(f=o.settings.paste_retain_style_properties,f&&(p=e.makeMap(f)),o.settings.paste_enable_default_filters!==!1&&/class="?Mso|style="[^"]*\bmso-|style='[^'']*\bmso-|w:WordDocument/i.test(s.content)){s.wordContent=!0,l([/<!--[\s\S]+?-->/gi,/<(!|script[^>]*>.*?<\/script(?=[>\s])|\/?(\?xml(:\w+)?|img|meta|link|style|\w:\w+)(?=[\s\/>]))[^>]*>/gi,[/<(\/?)s>/gi,"<$1strike>"],[/&nbsp;/gi,"\xa0"],[/<span\s+style\s*=\s*"\s*mso-spacerun\s*:\s*yes\s*;?\s*"\s*>([\s\u00a0]*)<\/span>/gi,function(e,t){return t.length>0?t.replace(/./," ").slice(Math.floor(t.length/2)).split("").join("\xa0"):""}]]);var m=new n({valid_elements:"@[style],-strong/b,-em/i,-span,-p,-ol,-ul,-li,-h1,-h2,-h3,-h4,-h5,-h6,-table,-tr,-td[colspan|rowspan],-th,-thead,-tfoot,-tbody,-a[!href]"}),h=new t({},m);h.addAttributeFilter("style",function(e){for(var t=e.length,n;t--;)n=e[t],n.attr("style",d(n,n.attr("style"))),"span"!=n.name||n.attributes.length||n.unwrap()});var g=h.parse(u);c(g),s.content=new r({},m).serialize(g)}})}}),r(v,[c,d],function(e,t){return function(n){function r(e){n.on("PastePreProcess",function(t){t.content=e(t.content)})}function i(e,n){return t.each(n,function(t){e=t.constructor==RegExp?e.replace(t,""):e.replace(t[0],t[1])}),e}function o(e){return e=i(e,[/^[\s\S]*<!--StartFragment-->|<!--EndFragment-->[\s\S]*$/g,[/<span class="Apple-converted-space">\u00a0<\/span>/g,"\xa0"],/<br>$/])}function a(e){if(!s){var r=[];t.each(n.schema.getBlockElements(),function(e,t){r.push(t)}),s=new RegExp("(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*(<\\/?("+r.join("|")+")[^>]*>)(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*","g")}return e=i(e,[[s,"$1"]]),e=i(e,[[/<br><br>/g,"<BR><BR>"],[/<br>/g," "],[/<BR><BR>/g,"<br>"]])}var s;e.webkit&&r(o),e.ie&&r(a)}}),r(y,[b,l,f,v],function(e,t,n,r){var i;e.add("paste",function(e){var o=this,a;o.clipboard=a=new t(e),o.quirks=new r(e),o.wordFilter=new n(e),e.settings.paste_as_text&&(o.clipboard.pasteFormat="text"),e.addCommand("mceInsertClipboardContent",function(e,t){t.content&&o.clipboard.paste(t.content),t.text&&o.clipboard.pasteText(t.text)}),e.addMenuItem("pastetext",{text:"Paste as text",selectable:!0,active:a.pasteFormat,onclick:function(){"text"==a.pasteFormat?(this.active(!1),a.pasteFormat="html"):(a.pasteFormat="text",this.active(!0),i||(e.windowManager.alert("Paste is now in plain text mode. Contents will now be pasted as plain text until you toggle this option off."),i=!0))}})})}),a([l,f,v,y])}(this);