console.log("dialog film");
class DialogScreen {
    // hàm tạo -> truyền vào 1 selecter[class hoặc id]
    constructor(selector = ".time-select__item"){
        this.selector = selector;
        this.url_get_info = ''; //
        this.cache_data = {}; 
        // dùng làm bộ nhơ tạm để lưu những film đã load. lần sau không phải load lại
        this.flag_create_popup = false;
        // trạng thái đã tạo popup chưa -> defaul : false
    }
    // hàm xử  lý -> tiến hành build 1 hành động từ constructor
    init(){
        this.handleHover();
    }

    handleHover(){
        let self = this;
        //console.log(self)
        // bind sự kiện khi người dùng hover vào 1 suất chiếu
        $(document).on("mouseenter", self.selector, function(){
            
            $(this).css("color","blue")
            let current_screen_id = $(this).data().screen
            let current_url = $(this).attr("data-url")
            //console.log(current_screen_id)
            // xử lý popup với thằng được hover
            self.processPopup(this)
            // xử lý sự kiện hover với mỗi id truyền vào
            self.hoverEvent(current_screen_id, current_url)
        })

        $('body').mousemove(function(e){
            //console.log("sự kiện mousemove");
            if($(e.target).closest(self.selector + ', .dialog-screen-info').length == 0){
                self.hidePopup();
            }
            //console.log($(e.target).closest(self.selector + '.dialog-screen-info'))
        })
    }
    processPopup(taget_hover){
        //taget_hover thằng đang được hover
        console.log($(this));
        //hàm này kiểm tra xem popup đã được tạo hay chưa? nếu chưa có thì create
        !this.flag_create_popup && this.createPopup()
        //nếu có rồi thì show
        this.processPosition(taget_hover);
        this.showPopup();
        
    }
    async hoverEvent(target_id, current_url){
        let data;
        //check data cache
        if(this.cache_data[target_id] === undefined){
            // kiểm tra nếu chưa có cache_data của id này thì gửi rq lên sever
            //-> lấy data về và gán vào caceh
            //hiển thị load animation
            this.popup.html(this.tenmplateLoading());
            // thực hiện 1 request đến sever lấy thông tin của screen về gán và cachedata

            data = await this.getData(target_id, current_url);
            this.cache_data[data.id] = data
        }else{
            data = this.cache_data[target_id]
        }
        console.log(data)
        // xử lý khi có data screen
        this.processData(data)
    }
    tenmplateLoading() {
        return (`
            <div class="loader"></div>
        `)
    }
    createPopup(){
        this.flag_create_popup = true;
        this.popup = $(this.templdatePopup())
        //tạo popup
        console.log("show popup");
        $('body').append(this.popup)
    }
    processPosition(taget_hover){
        this.popup.removeClass('on-top on-bottom')
        let window_height = $(window).height();
        let offset = $(taget_hover).offset();
        let offset_viewport_top = $(taget_hover).offset().top - $(window).scrollTop();
        if(window_height/2 > offset_viewport_top){
            console.log("hiện ở dưới");
            this.popup.css('top', offset.top + $(taget_hover).innerHeight()+10)
            this.popup.addClass('on-bottom');
        }else{
            //  hien o tren
            console.log("hiện ở trên");
            this.popup.css('top', offset.top);
            this.popup.addClass('on-top');
        }
        this.popup.css('left', offset.left);
    }

    hidePopup() {
        if(this.popup){
            this.popup.removeClass('active');
        }
       
    }


    processData(data){
        let html_data = this.templateScreeningPopup(data);
        this.popup.html(html_data)
    }
    templateScreeningPopup(data){
        let screen_data = data.screen_data
        let screen_part = data.screen_part
        console.log(screen_data);
        return(`
                <div >
                    <div class="d-flex align-items-center text-left">
                        <div class="ml-2">
                            <h5 class="text-left m-0"><p class="d-inline m-0">Tên phim: </p><a href="${data.screen_part}" style = "font-size: 20px; color: green;">${screen_data.film_name}</a></h5>
                            <p class="mb-0">Rạp: ${screen_data.room_name}</p>
                            <div>
                                <div class="mr-3">
                                    <span class="mdi mdi-pencil"></span>
                                    <span>Ghế trống: ${screen_data.seat_slot}</span>
                                </div>
                                <div class="mr-3">
                                    <span class="mdi mdi-account-multiple-plus"></span>
                                    <span>Thời gian: ${screen_data.format_start_film_at}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        `)
    }
    showPopup() {
        // hien thi len = cach add class active
        this.popup.addClass('active');
    }
    templdatePopup(){
        return (`
            <div class="dialog-screen-info">
                
            </div>
        `)
    }
    getData(id, url){
        return $.ajax({
            url: `${url}/`+id,
            dataType: 'json',
            type: 'GET'
        })
    }
}

$(function () {

    new DialogScreen().init();
  })