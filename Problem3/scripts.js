//Iterate through fields on the form and checking them according to there type and attribute
function validate() {
    for (var i = 0; i < document.form.elements.length; i++) {
        var field = document.form.elements[i];
        if (field.getAttribute("required") == "true" && (field.value == "" || field.value == null)) {
            alert("Field \"" + field.name + "\" is required");
        }
        if (field.getAttribute("type") == "text") {
            if (field.getAttribute("regexp") != null
                && !new RegExp(field.getAttribute("regexp")).test(field.value)) {
                if (field.getAttribute("error") != null) {
                    alert(field.getAttribute("error"));
                } else {
                    alert("Value in field \"" + field.name + "\" should match " + field.getAttribute("regexp"));
                }
            }
            if (field.getAttribute("max-length") != null
                && field.value.length > field.getAttribute("max-length")) {
                if (field.getAttribute("error") != null) {
                    alert(field.getAttribute("error"));
                } else {
                    alert("Value in field \"" + field.name + "\" should be less than " + field.getAttribute("max-length") + " characters");
                }
            }
        } else if (field.getAttribute("type") == "number") {
            var max = field.getAttribute("max");
            var min = field.getAttribute("min");
            if (field.value > max) {
                if (field.getAttribute("error") != null) {
                    alert(field.getAttribute("error"));
                } else {
                    alert("Value in field \'" + field.name + "\" should be less than " + max);
                }
            } else if (field.value < min) {
               if (field.getAttribute("error") != null) {
                   alert(field.getAttribute("error"));
               } else {
                   alert("Value in field \"" + field.name + "\" should be greater than " + min);
               }
           }
        }
    }
    return false;
}
