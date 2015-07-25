var ra={};
ra.util = {
  keyCode: function(b) {
    if(!b) {
      var b=window.event
    }
    return b.keyCode
  },
  isCtrl: function(a) {
    if(!a) {
      var a=window.event
    }
    return a.ctrlKey
  },
  isAlt: function(a) {
    if(!a) {
      var a=window.event
    }
    return a.altKey
  },
  isShift: function(a) {
    if(!a) {
      var a=window.event
    }
    return a.shiftKey
  },
  insertAtCaret: function(c,d) {
    var f=this.getSelectionStart(c);
    var b=this.getSelectionEnd(c);
    var a=c.value.length;
    c.value=c.value.substring(0,f)+d+c.value.substring(b,a);
    this.setCaretPosition(c,f+d.length,0)
  },
  deleteAtCaret: function(d,c,g) {
    var h=this.getSelectionStart(d);
    var b=this.getSelectionEnd(d);
    var a=d.value.length;
    if(c>h) {
      c=h
    }
    if(b+g>a) {
      g=a-b
    }
    var f=d.value.substring(h-c,b+g);
    d.value=d.value.substring(0,h-c)+d.value.substring(b+g);
    this.setCaretPosition(d,h-c,0);
    return f
  },
  getSelectionStart: function(d) {
    d.focus();
    if(d.selectionStart!==undefined) {
      return d.selectionStart
    } else {
      if(document.selection) {
        var b=document.selection.createRange();
        if(b==null) {
          return 0
        }
        var a=d.createTextRange();
        var c=a.duplicate();
        a.moveToBookmark(b.getBookmark());
        c.setEndPoint("EndToStart",a);
        return c.text.length
      }
    }
    return 0
  },
  getSelectionEnd: function(d) {
    d.focus();
    if(d.selectionEnd!==undefined) {
      return d.selectionEnd
    } else {
      if(document.selection) {
        var b=document.selection.createRange();
        if(b==null) {
          return 0
        }
        var a=d.createTextRange();
        var c=a.duplicate();
        a.moveToBookmark(b.getBookmark());
        c.setEndPoint("EndToStart",a);
        return c.text.length+b.text.length
      }
    }
    return d.value.length
  },
  setCaretPosition: function(d,f,c) {
    var a=d.value.length;
    if(f>a) {
      f=a
    }
    if(f+c>a) {
      c=a-c
    }
    d.focus();
    if(d.setSelectionRange) {
      d.setSelectionRange(f,f+c)
    } else {
      if(d.createTextRange) {
        var b=d.createTextRange();
        b.collapse(true);
        b.moveEnd("character",f+c);
        b.moveStart("character",f);
        b.select()
      }
    }
    d.focus()
  },
  selectAll: function(a) {
    this.setCaretPosition(a,0,a.value.length)
  }
};
ra.layout=function() {
  this.keys=[];
  this.deadkeys=[];
  this.dir="ltr";
  this.name="US";
  this.lang="en"
};
ra.layout.prototype.loadDefault=function() {
  this.keys=[
  {i:"k0",c:"0",n:"`",s:"~"},
  {i:"k1",c:"0",n:"1",s:"!"},
  {i:"k2",c:"0",n:"2",s:"@"},
  {i:"k3",c:"0",n:"3",s:"#"},
  {i:"k4",c:"0",n:"4",s:"$"},
  {i:"k5",c:"0",n:"5",s:"%"},
  {i:"k6",c:"0",n:"6",s:"^"},
  {i:"k7",c:"0",n:"7",s:"&"},
  {i:"k8",c:"0",n:"8",s:"*"},
  {i:"k9",c:"0",n:"9",s:"("},
  {i:"k10",c:"0",n:"0",s:")"},
  {i:"k11",c:"0",n:"-",s:"_"},
  {i:"k12",c:"0",n:"=",s:"+"},
  {i:"k13",c:"1",n:"q",s:"Q"},
  {i:"k14",c:"1",n:"w",s:"W"},
  {i:"k15",c:"1",n:"e",s:"E"},
  {i:"k16",c:"1",n:"r",s:"R"},
  {i:"k17",c:"1",n:"t",s:"T"},
  {i:"k18",c:"1",n:"y",s:"Y"},
  {i:"k19",c:"1",n:"u",s:"U"},
  {i:"k20",c:"1",n:"i",s:"I"},
  {i:"k21",c:"1",n:"o",s:"O"},
  {i:"k22",c:"1",n:"p",s:"P"},
  {i:"k23",c:"0",n:"[",s:"{"},
  {i:"k24",c:"0",n:"]",s:"}"},
  {i:"k25",c:"0",n:"\\",s:"|"},
  {i:"k26",c:"1",n:"a",s:"A"},
  {i:"k27",c:"1",n:"s",s:"S"},
  {i:"k28",c:"1",n:"d",s:"D"},
  {i:"k29",c:"1",n:"f",s:"F"},
  {i:"k30",c:"1",n:"g",s:"G"},
  {i:"k31",c:"1",n:"h",s:"H"},
  {i:"k32",c:"1",n:"j",s:"J"},
  {i:"k33",c:"1",n:"k",s:"K"},
  {i:"k34",c:"1",n:"l",s:"L"},
  {i:"k35",c:"0",n:";",s:":"},
  {i:"k36",c:"0",n:"'",s:'"'},
  {i:"k37",c:"1",n:"z",s:"Z"},
  {i:"k38",c:"1",n:"x",s:"X"},
  {i:"k39",c:"1",n:"c",s:"C"},
  {i:"k40",c:"1",n:"v",s:"V"},
  {i:"k41",c:"1",n:"b",s:"B"},
  {i:"k42",c:"1",n:"n",s:"N"},
  {i:"k43",c:"1",n:"m",s:"M"},
  {i:"k44",c:"0",n:",",s:"<"},
  {i:"k45",c:"0",n:".",s:">"},
  {i:"k46",c:"0",n:"/",s:"?"},
  {i:"k47",c:"0",n:"\\",s:"|"}
  ];
  this.dir="ltr";
  this.name="US";
  this.lang="en"
};
ra.layout.prototype.load=function(a) {
  this.keys=a.keys;
  this.deadkeys=a.deadkeys;
  this.dir=a.dir;
  this.name=a.name;
  this.lang=a.lang?a.lang:"en"
};
ra.layout.parser= {
  keyCodes: [192,49,50,51,52,53,54,55,56,57,48,189,187,81,87,69,82,84,89,85,73,79,80,219,221,220,65,83,68,70,71,72,74,75,76,186,222,90,88,67,86,66,78,77,188,190,191,220],
  getKeyCode: function(d,b,e) {
    var a=d.length;
    for(var c=0;c<a;c++) {
      if(d[c].i==e) {
        return b==1?(d[c].s?d[c].s:""):(d[c].n?d[c].n:"")
      }
    }
    return 0
  },
  getKey: function(c,d) {
    var a=c.length;
    for(var b=0;b<a;b++) {
      if(c[b].i==d) {
        return c[b]
      }
    }
    return null
  },
  isDeadkey: function(b,d) {
    if(!b) {
      return false
    }
    var a=b.length;
    for(var c=0;c<a;c++) {
      if(b[c].k==d) {
        return true
      }
    }
    return false
  },
  getMappedValue: function(b,e,d) {
    if(!b) {
      return""
    }
    var a=b.length;
    for(var c=0;c<a;c++) {
      if(b[c].k==d&&b[c].b==e) {
        return b[c].c
      }
    }
    return""
  },
  getKeyId: function(b) {
    for(var a=0;a<48;a++) {
      if(this.keyCodes[a]==b) {
        return a
      }
    }
    return -1
  },
  getState: function(d,f,a,b,e) {
    var c="n";
    if(!f&&!a&&d) {
      c="n"
    } else {
      if(!f&&a&&!d) {
        c="s"
      } else {
        if(!f&&a&&d) {
          c="s" } else {
            if(f&&!a&&!d) {
              c="n"
            } else {
              if(f&&!a&&d) {
                c="t"
              } else {
                if(f&&a&&!d) {
                  c="s"
                } else {
                  if(f&&a&&d) {
                    c="f"
                  }
                }
              }
            }
          }
      }
    }
    if((c=="n"||c=="s")&&b) {
      if(e=="1") {
        if(c=="n") {
          c="s"
        } else {
          c="n"
        }
      }
      if(e=="SGCap") {
        if(c=="n") {
          c="y"
        } else {
          if(c=="s") {
            c="z"
          }
        }
      }
    }
    return c
  }
};
ra.keyboard=function(a,b) {
  this.defaultLayout=new ra.layout();
  this.defaultLayout.loadDefault();
  this.virtualLayout=new ra.layout();
  this.virtualLayout.loadDefault();
  this.virtualLayout2=new ra.layout();
  this.virtualLayout2.loadDefault();
  this.currentLayout=this.virtualLayout;
  this.shift=false;
  this.caps=false;
  this.alt=false;
  this.ctrl=false;
  this.counter=0;
  this.interval=0;
  this.prev="";
  this.cancelkeypress=false;
  this.customOnBackspace=function(e) {};
  this.customOnEnter=function() {};
  this.customOnSpace=function() {
    return false
  };
  this.customOnKey=function(e) {
    return false
  };
  this.customOnEsc=function() {};
  this.customDrawKeyboard=function(e) {
    return e
  };
  this.textbox=$("#"+b);
  this.nativeTextbox=document.getElementById(b);
  var d=['<div id="ra-keyboard">'];
  for(var c=0;c<13;c++) {
    d.push('<button id="ra-k',c,'" class="ra-key btn btn-default"></button>')
  }
  d.push('<button id="ra-backspace" class="btn btn-default"><span>Backspace</span></button>');
  d.push('<div class="ra-clear"></div>');
  d.push('<button id="ra-tab" class="btn btn-default"><span>Tab</span></button>');
  for(var c=13;c<25;c++) {
    d.push('<button id="ra-k',c,'" class="ra-key btn btn-default"></button>')
  }
  d.push('<button id="ra-k25" class="btn btn-default"></button>');
  d.push('<div class="ra-clear"></div>');
  d.push('<button id="ra-caps-lock" class="btn btn-default"><span>Caps</span></button>');
  for(var c=26;c<37;c++) {
    d.push('<button id="ra-k',c,'" class="ra-key btn btn-default"></button>')
  }
  d.push('<button id="ra-enter" class="ra-enter btn btn-default"><span>Enter</span></button>');
  d.push('<div class="ra-clear"></div>');
  d.push('<button id="ra-left-shift" class="btn btn-default"><span>Shift</span></button>');
  d.push('<button id="ra-k47" class="ra-key btn btn-default"></button>');
  for(var c=37;c<47;c++) {
    d.push('<button id="ra-k',c,'" class="ra-key btn btn-default"></button>')
  }
  d.push('<button id="ra-right-shift" class="btn btn-default"><span>Shift</span></button>');
  d.push('<div class="ra-clear"></div>');
  d.push('<button id="ra-left-ctrl" class="btn btn-default"><span>Ctrl</span></button>');
  d.push('<button id="ra" class="btn btn-default"><span></span></button>');
  d.push('<button id="ra-left-alt" class="btn btn-default"><span>Alt</span></button>');
  d.push('<button id="ra-space" class="btn btn-default"><span>Space</span></button>');
  d.push('<button id="ra-right-alt" class="btn btn-default"><span>Alt</span></button>');
  d.push('<button id="ra" class="btn btn-default"><span></span></button>');
  d.push('<button id="ra-right-ctrl" class="btn btn-default"><span>Ctrl</span></button>');
  d.push('<div class="ra-clear"></div>');
  d.push("</div>");
  document.getElementById(a).innerHTML=d.join("");
  this.wireEvents();
  this.drawKeyboard()
};
ra.keyboard.prototype.loadDefaultLayout=function(a) {
  this.defaultLayout.load(a);
  this.drawKeyboard()
};
ra.keyboard.prototype.loadVirtualLayout=function(a) {
  this.virtualLayout.load(a);
  this.drawKeyboard();
  this.textbox.attr("dir",this.attr("dir"))
};
ra.keyboard.prototype.loadVirtualLayout2=function(a) {
  this.virtualLayout2.load(a);
  this.drawKeyboard();
  this.textbox.attr("dir",this.attr("dir"))
};
ra.keyboard.prototype.switchLayout=function() {
  this.currentLayout=(this.currentLayout===this.virtualLayout)?this.virtualLayout2:this.virtualLayout;
  this.reset();
  this.drawKeyboard();
  this.textbox.attr("dir",this.attr("dir"))
};
ra.keyboard.prototype.switchLayoutRu=function() {
  this.currentLayout=this.virtualLayout2;
  this.reset();
  this.drawKeyboard();
  this.textbox.attr("dir",this.attr("dir"))
};
ra.keyboard.prototype.switchLayoutAr=function() {
  this.currentLayout=this.virtualLayout;
  this.reset();
  this.drawKeyboard();
  this.textbox.attr("dir",this.attr("dir"))
};
ra.keyboard.prototype.onEsc=function() {
  this.switchLayout();
  this.customOnEsc()
};
ra.keyboard.prototype.onShift=function() {
  this.shift=!this.shift;
  this.drawKeyboard()
};
ra.keyboard.prototype.onAlt=function() {
  this.alt=!this.alt;
  this.drawKeyboard()
};
ra.keyboard.prototype.onCtrl=function() {
  this.ctrl=!this.ctrl;
  this.drawKeyboard()
};
ra.keyboard.prototype.onCapsLock=function() {
  this.caps=!this.caps;
  this.drawKeyboard()
};
ra.keyboard.prototype.onBackspace=function() {
  if(this.prev!="") {
    this.prev="";
    this.shift=false;
    this.drawKeyboard()
  } else {
    var a=ra.util.deleteAtCaret(this.nativeTextbox,1,0);
    this.customOnBackspace(a)
  }
};
ra.keyboard.prototype.onEnter=function() {
  this.textbox.closest("form").submit();
  this.customOnEnter()
};
ra.keyboard.prototype.onSpace=function() {
  if(!this.customOnSpace()) {
    ra.util.insertAtCaret(this.nativeTextbox,"\u0020")
  }
};
ra.keyboard.prototype.attr=function(a) {
  if(a=="dir") {
    return this.currentLayout.dir
  } else {
    if(a=="lang") {
      return this.currentLayout.lang
    } else {
      if(a=="name") {
        return this.currentLayout.name
      }
    }
  }
  return""
};
ra.keyboard.prototype.reset=function() {
  this.shift=false;
  this.caps=false;
  this.alt=false;
  this.ctrl=false;
  this.counter=0;
  this.interval=0;
  this.prev=""
};
ra.keyboard.prototype.stopRepeat=function() {
  if(this.interval!=0) {
    clearInterval(this.interval);
    this.counter=0;
    this.interval=0
  }
};
ra.keyboard.prototype.onKey=function(e) {
  var b=ra.layout.parser.getKey(this.currentLayout.keys,e);
  if(b) {
    var d=ra.layout.parser.getState(this.ctrl,this.alt,this.shift,this.caps,b.c?b.c:"0");
    var c=b[d]?b[d]:"";
    if(this.prev!="") {
      var a=ra.layout.parser.getMappedValue(this.currentLayout.deadkeys,c,this.prev);
      if(a!="") {
        ra.util.insertAtCaret(this.nativeTextbox,a)
      }
      this.prev=""
    } else {
      if(ra.layout.parser.isDeadkey(this.currentLayout.deadkeys,c)) {
        this.prev=c
      } else {
        if(c!="") {
          if(!this.customOnKey(c)) {
            ra.util.insertAtCaret(this.nativeTextbox,c)
          }
        }
      }
    }
  }
};
ra.keyboard.prototype.drawKeyboard=function() {
  if(!this.currentLayout.keys) {
    return
  }
  var d,c,f,e;
  var a=this.currentLayout.keys.length;
  for(var b=0;b<a;b++) {
    c=this.currentLayout.keys[b];
    if(!$("ra-"+c.i)) {
      continue
    }
    f=ra.layout.parser.getState(this.ctrl,this.alt,this.shift,this.caps,c.c?c.c:"0");
    e=c[f]?c[f]:"";
    if(this.prev!="") {
      e=ra.layout.parser.getMappedValue(this.currentLayout.deadkeys,e,this.prev)
    }
    if(!this.shift) {
      e=this.customDrawKeyboard(e);
      if(e=="") {
        e="&nbsp;"
      }
      d='<div class="ra-label-reference">'
        +ra.layout.parser.getKeyCode(this.defaultLayout.keys,0,c.i)
        +'</div><div class="ra-label-natural">'+e+"</div>"
    } else {
      if(e=="") {
        e="&nbsp;"
      }
      d='<div class="ra-label-reference">'
        +ra.layout.parser.getKeyCode(this.defaultLayout.keys,0,c.i)
        +'</div><div class="ra-label-shift">'+e+"</div>"
    }
    document.getElementById("ra-"+c.i).innerHTML=d
  }
  if(this.ctrl) {
    $("#ra-left-ctrl").addClass("ra-recessed");
    $("#ra-right-ctrl").addClass("ra-recessed")
  } else {
    $("#ra-left-ctrl").removeClass("ra-recessed");
    $("#ra-right-ctrl").removeClass("ra-recessed")
  }
  if(this.alt) {
    $("#ra-left-alt").addClass("ra-recessed");
    $("#ra-right-alt").addClass("ra-recessed")
  } else {
    $("#ra-left-alt").removeClass("ra-recessed");
    $("#ra-right-alt").removeClass("ra-recessed")
  }
  if(this.shift) {
    $("#ra-left-shift").addClass("ra-recessed");
    $("#ra-right-shift").addClass("ra-recessed")
  } else {
    $("#ra-left-shift").removeClass("ra-recessed");
    $("#ra-right-shift").removeClass("ra-recessed")
  }
  if(this.caps) {
    $("#ra-caps-lock").addClass("ra-recessed")
  } else {
    $("#ra-caps-lock").removeClass("ra-recessed")
  }
};
ra.keyboard.prototype.wireEvents=function() {
  var a=this;
  $("#ra-keyboard").delegate("button","mousedown",function(c) {
    var b=this.id;
    a.interval=setInterval(function() {
      a.counter++;
      if(a.counter>5) {
        switch(b) {
        case"ra-backspace": a.onBackspace();
                            break;
        default: if(b.search("ra-k([0-9])|([1-3][0-9])|(4[0-7])")!=-1) {
          a.onKey(b.substr(3));
          a.shift=false;
          a.alt=false;
          a.ctrl=false;
          a.drawKeyboard()
        }
                 break
        }
      }
    },
    50)
  });
  $("#ra-keyboard").delegate("button","mouseup",function(b) {
    a.stopRepeat()
  });
  $("#ra-keyboard").delegate("button","mouseout",function(b) {
    a.stopRepeat()
  });
  $("#ra-keyboard").delegate("button","click",function(c) {
    var b=this.id;
    switch(b) {
    case"ra-left-shift":
    case"ra-right-shift": a.onShift();
                          break;
    case"ra-left-alt":
    case"ra-right-alt": a.onAlt();
                        break;
    case"ra-left-ctrl":
    case"ra-right-ctrl": a.onCtrl();
                         break;
    case"ra-escape": a.onEsc();
                     break;
    case"ra-caps-lock": a.onCapsLock();
                        break;
    case"ra-backspace": a.onBackspace();
                        break;
    case"ra-enter": a.onEnter();
                    break;
    case"ra-space": a.onSpace();
                    break;
    default: if(b.search("ra-k([0-9])|([1-3][0-9])|(4[0-7])")!=-1) {
      a.onKey(b.substr(3));
      a.shift=false;
      a.alt=false;
      a.ctrl=false;
      a.drawKeyboard()
    }
             break
    }
  });
  a.textbox.bind("keydown",function(d) {
    var c=ra.util.keyCode(d);
    if((c==82||c==65||c==67||c==86||c==88||c==89||c==90)&&(a.ctrl&&!a.alt&&!a.shift)) {
      return
    }
    if(a.currentLayout==a.defaultLayout&&c!=27) {
      return
    }
    switch(c) {
    case 17: a.ctrl=false;
             a.onCtrl();
             break;
    case 18: break;
    case 16: a.shift=false;
             a.onShift();
             break;
    case 27: break;
    case 8: a.onBackspace();
            d.preventDefault();
            break;
    case 32: a.onSpace();
             d.preventDefault();
             break;
    case 10: a.onEnter();
             d.preventDefault();
             break;
    default: var b=ra.layout.parser.getKeyId(ra.util.keyCode(d));
             if(b!=-1) {
               a.onKey("k"+b);
               a.drawKeyboard();
               d.preventDefault();
               a.cancelkeypress=true
             }
             break
    }
  });
  a.textbox.bind("keyup",function(b) {
    switch(ra.util.keyCode(b)) {
    case 17: a.ctrl=true;
             a.onCtrl();
             break;
    case 18: break;
    case 16: a.shift=true;
             a.onShift();
             break;
    default:
    }
  })
};
var keyboard=null;
$(document).ready(function() {
  keyboard=new ra.keyboard("ra-keyboard","search_box");
  var a = { name: "Arabic",
    dir: "rtl",
    keys: [
            {i:"k0",c:"0",n:"\u0630",s:"\u0651"},
            {i:"k1",c:"0",n:"\u0661",s:"!"},
            {i:"k2",c:"0",n:"\u0662",s:"@"},
            {i:"k3",c:"0",n:"\u0663",s:"#"},
            {i:"k4",c:"0",n:"\u0664",s:"$",t:"\u00a4"},
            {i:"k5",c:"0",n:"\u0665",s:"%"},
            {i:"k6",c:"0",n:"\u0666",s:"^"},
            {i:"k7",c:"0",n:"\u0667",s:"&"},
            {i:"k8",c:"0",n:"\u0668",s:"*"},
            {i:"k9",c:"0",n:"\u0669",s:")"},
            {i:"k10",c:"0",n:"\u0660",s:"("},
            {i:"k11",c:"0",n:"-",s:"_"},
            {i:"k12",c:"0",n:"=",s:"+"},
            {i:"k13",c:"1",n:"\u0636",s:"\u064e"},
            {i:"k14",c:"1",n:"\u0635",s:"\u064b"},
            {i:"k15",c:"1",n:"\u062b",s:"\u064f"},
            {i:"k16",c:"1",n:"\u0642",s:"\u064c"},
            {i:"k17",c:"1",n:"\u0641",s:"\ufef9"},
            {i:"k18",c:"1",n:"\u063a",s:"\u0625"},
            {i:"k19",c:"1",n:"\u0639",s:"\u2019"},
            {i:"k20",c:"1",n:"\u0647",s:"\u00f7"},
            {i:"k21",c:"1",n:"\u062e",s:"\u00d7"},
            {i:"k22",c:"1",n:"\u062d",s:"\u061b"},
            {i:"k23",c:"0",n:"\u062c",s:">"},
            {i:"k24",c:"0",n:"\u062f",s:"<"},
            {i:"k25",c:"0",n:"\\",s:"|"},
            {i:"k26",c:"0",n:"\u0634",s:"\u0650"},
            {i:"k27",c:"1",n:"\u0633",s:"\u064d"},
            {i:"k28",c:"1",n:"\u064a",s:"]"},
            {i:"k29",c:"1",n:"\u0628",s:"["},
            {i:"k30",c:"1",n:"\u0644",s:"\u0644\u0623"},
            {i:"k31",c:"1",n:"\u0627",s:"\u0623"},
            {i:"k32",c:"1",n:"\u062a",s:"\u0640"},
            {i:"k33",c:"1",n:"\u0646",s:"\u060c"},
            {i:"k34",c:"1",n:"\u0645",s:"/"},
            {i:"k35",c:"1",n:"\u0643",s:":"},
            {i:"k36",c:"1",n:"\u0637",s:'"'},
            {i:"k37",c:"1",n:"\u0626",s:"~"},
            {i:"k38",c:"1",n:"\u0621",s:"\u0652"},
            {i:"k39",c:"1",n:"\u0624",s:"{"},
            {i:"k40",c:"1",n:"\u0631",s:"}"},
            {i:"k41",c:"1",n:"\u0644\u0627",s:"\u0644\u0622"},
            {i:"k42",c:"1",n:"\u0649",s:"\u0622"},
            {i:"k43",c:"1",n:"\u0629",s:"\u2018"},
            {i:"k44",c:"0",n:"\u0648",s:","},
            {i:"k45",c:"0",n:"\u0632",s:"."},
            {i:"k46",c:"0",n:"\u0638",s:"\u061f"},
            {i:"k47",c:"0",n:"\\",s:"|"}
          ],
    deadkeys:[]
  };
  var b = { name: "Russian",
    keys: [
      {i:"k0",c:"0",n:"`",s:"Ё"},
      {i:"k1",c:"0",n:"1",s:"!"},
      {i:"k2",c:"0",n:"2",s:'"'},
      {i:"k3",c:"0",n:"3",s:"№"},
      {i:"k4",c:"0",n:"4",s:";"},
      {i:"k5",c:"0",n:"5",s:"%"},
      {i:"k6",c:"0",n:"6",s:":"},
      {i:"k7",c:"0",n:"7",s:"?"},
      {i:"k8",c:"0",n:"8",s:"*"},
      {i:"k9",c:"0",n:"9",s:"("},
      {i:"k10",c:"0",n:"0",s:")"},
      {i:"k11",c:"0",n:"-",s:"_"},
      {i:"k12",c:"0",n:"=",s:"+"},
      {i:"k13",c:"1",n:"й",s:"Й"},
      {i:"k14",c:"1",n:"ц",s:"Ц"},
      {i:"k15",c:"1",n:"у",s:"У"},
      {i:"k16",c:"1",n:"к",s:"К"},
      {i:"k17",c:"1",n:"е",s:"Е"},
      {i:"k18",c:"1",n:"н",s:"Н"},
      {i:"k19",c:"1",n:"г",s:"Г"},
      {i:"k20",c:"1",n:"ш",s:"Ш"},
      {i:"k21",c:"1",n:"щ",s:"Щ"},
      {i:"k22",c:"1",n:"з",s:"З"},
      {i:"k23",c:"0",n:"х",s:"Х"},
      {i:"k24",c:"0",n:"ъ",s:"Ъ"},
      {i:"k25",c:"0",n:"\\",s:"/"},
      {i:"k26",c:"1",n:"ф",s:"Ф"},
      {i:"k27",c:"1",n:"ы",s:"Ы"},
      {i:"k28",c:"1",n:"в",s:"В"},
      {i:"k29",c:"1",n:"а",s:"А"},
      {i:"k30",c:"1",n:"п",s:"П"},
      {i:"k31",c:"1",n:"р",s:"Р"},
      {i:"k32",c:"1",n:"о",s:"О"},
      {i:"k33",c:"1",n:"л",s:"Л"},
      {i:"k34",c:"1",n:"д",s:"Д"},
      {i:"k35",c:"0",n:"ж",s:"Ж"},
      {i:"k36",c:"0",n:"э",s:'Э'},
      {i:"k37",c:"1",n:"я",s:"Я"},
      {i:"k38",c:"1",n:"ч",s:"Ч"},
      {i:"k39",c:"1",n:"с",s:"С"},
      {i:"k40",c:"1",n:"м",s:"М"},
      {i:"k41",c:"1",n:"и",s:"И"},
      {i:"k42",c:"1",n:"т",s:"Т"},
      {i:"k43",c:"1",n:"ь",s:"Ь"},
      {i:"k44",c:"0",n:"б",s:"Б"},
      {i:"k45",c:"0",n:"ю",s:"Ю"},
      {i:"k46",c:"0",n:".",s:","},
      {i:"k47",c:"0",n:"\\",s:"|"}
    ],
    name: "RU",
    lang: "ru",
    dir: "ltr",
    deadkeys:[]
  };
  keyboard.loadVirtualLayout(a);
  keyboard.loadVirtualLayout2(b);
  $('#search_box').focus();
  if($('#search_type').attr("value") == "exact") {
    $('#search_exact').click();
  }
  if($('#input_lang').attr("value") == "ru") {
    $('#ruar').click();
  }
});
