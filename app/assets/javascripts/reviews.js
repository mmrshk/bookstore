$(document).ready(function () {
    $('#new_review').validate({
        rules: {
            name: {
                required: true,
            },
            comment: {
                required: true
            }
        }
    });

    $('#new_review input').on('click', checkForm);

    function checkForm() {
        $("#new_review input[type=submit]")
            .prop("disabled", !($('#new_review').valid()));
    }

});
