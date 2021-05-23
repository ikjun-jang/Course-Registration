$(function() {
    var cPrefix = [
      "CE", "CS", "EE", "SE", "TE"
    ];
    $( "#cPrefix" ).autocomplete({
      source: cPrefix
    });
  });
$(function() {
    var cNum = [
       53579, 63569, 63569, 63579, 63589
    ];
    $( "#cNum" ).autocomplete({
      source: cNum
    });
  });
$(function() {
    var cName = [
      "Operating Systems", "Object Oriented Analysis and Design",
      "Advanced Operating Systems", "VLSI Design"
    ];
    $( "#cName" ).autocomplete({
      source: cName
    });
  });
$(function() {
    var cStatus = [
      "open", "closed"
    ];
    $( "#cStatus" ).autocomplete({
      source: cStatus
    });
  });
$(function() {
    var instructor = [
        "Mehra Nouroz Borazjany", "John Cole",
        "Ravi Prakash", "Carl Sechen"
    ];
    $( "#instructor" ).autocomplete({
      source: instructor
    });
  });
$(function() {
    var cLevel = [
      "graduate", "undergraduate"
    ];
    $( "#cLevel" ).autocomplete({
      source: cLevel
    });
  });
$(function() {
    var actDiff = [
      "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
    ];
    $( "#actDiff" ).autocomplete({
      source: actDiff
    });
  });