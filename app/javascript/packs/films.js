
var time = $('.choosen-time');
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

$('a.date').on('click',function(){
    // code
    let date = $(this).attr("data-date")
    
    // xoa class active truoc do
    $(".active").removeClass("active")
    //addclass active cho ngay duoc chon
    $(this).addClass("active")
    console.log(date);
    $.ajax({
        url: `/screen`,
        data: {
            filter: {
                date:date
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

$('a.day_show_film').on('click',function(){
    // code
    let date = $(this).attr("data-date")
    let film_id = $(".movie").attr("data-phim")
    // xoa class active truoc do
    $(".active").removeClass("active")
    //addclass active cho ngay duoc chon
    $(this).addClass("active")
    console.log(date);
    $.ajax({
        url: `/films/${film_id}/ticket_order`,
        data: {
            search: {
                date: date
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

    
    $(document).on('click', '.time-select__item',function(){
        //visual iteractive for choose
        $('.time-select__item').removeClass('active');
        $(this).addClass('active');

        //data element init
        var chooseTime = $(this).attr('data-screen');
        let url= $(this).attr("data-url");

        $("a#next_step_pick_seat").attr("href", url+"/"+chooseTime)

        $('.choose-indector--time').find('.choosen-area').text(chooseTime);

        //data element init
       // var chooseCinema = $(this).parent().parent().find('.time-select__place').text(); 

        //data element set
         time.val(chooseTime);
         console.log(time.val())
        // cinema.val(chooseCinema);
    });  
    //3. Choose sits (and count price for them)
    //users choose sits

    //data elements init
    var sum = 0;
    var cheap = 0;
    var middle = 0;
    var expansive = 0;
    

    $('.sits__place').on("click",function (e) {
        e.preventDefault();
        var place = $(this).attr('data-place');
        var ticketPrice = $(this).attr('data-price');

        if(! $(e.target).hasClass('sits-state--your')){

            if (! $(this).hasClass('sits-state--not') ) {
                $(this).addClass('sits-state--your');

                $('.checked-place').prepend('<span class="choosen-place '+place+' px-2 display-5">'+ place +'</span>');

                switch(ticketPrice)
                    {
                    case '50000':
                        sum += 50000;
                        cheap += 1;
                        break;
                    case '100000':
                        sum += 100000;
                        middle += 1;
                        break;
                }

                $('.checked-result').text(sum+' (VND)');
            }
        }

        else{
            $(this).removeClass('sits-state--your');
            
            $('.'+place+'').remove();

            switch(ticketPrice)
                    {
                    case '50000':
                        sum -= 50000;
                        cheap -= 1;
                        break;
                    case '100000':
                        sum -= 100000;
                        middle -= 1;
                        break;
                
                }

            $('.checked-result').text(sum+' (VND)')
        }
    })
$(".booking-pagination__next").on("click",function(e){
    if(time.val() ==  ""){
        e.preventDefault()
        alert("Bạn chưa chọn suất chiếu nào! Hãy chọn 1 suất chiếu")
    }
})
var list_seat_id = [];
var list_seat_name = [];
$("a.next_step_payment").on('click',function(e){
    if($('.web.checked-result').text().trim() == "0(VND)" || $('.web.checked-result').text() == "0 (VND)"){
        e.preventDefault()
        alert("Bạn chưa chọn ghế ngồi! Hãy chọn 1 vị trí muốn đặt")
    }
    $("span.sits-state--your").each(function(){
        list_seat_id.push($(this).attr("data-seat-id"))
        list_seat_name.push($(this).attr("data-place"))
     })
   sessionStorage.setItem('list_seat_id', list_seat_id);
   sessionStorage.setItem('total_payment',$('.web.checked-result').text())
   sessionStorage.setItem('list_seat_name', list_seat_name);
})
$(".book-result__count.booking-ticket").text(sessionStorage.getItem('list_seat_name')+" ("+(sessionStorage.getItem('list_seat_name').split(",").length)+" Vé"+")")
$(".book-result__count.booking-cost").text((sessionStorage.total_payment))


$(".add-food_to_order").on('click',function(e){
    e.preventDefault()
    $(this).addClass("d-none")
    $(this).next().removeClass("d-none")
    

})
$(".bootstrap-touchspin").addClass("w-50")
$(document).on('click', '.bootstrap-touchspin-down',function(){
    console.log($(this).closest(".input-group-prepend").next().val())
    let quantity = $(this).closest(".input-group-prepend").next().val();
    if(quantity == 0){
        $(".add-food_to_order").removeClass("d-none")
        $(".set_quantity_food").addClass("d-none")
    }
})