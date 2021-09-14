console.log(123)
$('input[name=day_show_film]').on('change',function(){

    let film_id = $(".movie").attr("data-phim")
        $.ajax({
                url: `/films/${film_id}`,
                data: {
                    search: {
                        date: $(this).val()
                    },
                    authenticity_token: AUTH_TOKEN
                },
                type: 'GET',
                dataType: 'script',
            }).done(function (data) {
                console.log(data)
            }).fail(function () {
                console.log(data)
            })
    });