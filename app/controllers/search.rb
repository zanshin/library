get '/search' do
    puts "[INFO] reached /search"
    @books = Book.all(:composer.like => "%#{params[:query]}%") | 
             Book.all(:composition.like => "%#{params[:query]}%") |
             Book.all(:edition.like => "%#{params[:query]}%") |
             Book.all(:type.like => "%#{params[:query]}%")
    puts "[INFO} found #{@books.count} books"
    @subhead = "Search results for '#{params[:query]}'"
    @items = @books.count
    @allbooks = Book.all
    @totalitems = @allbooks.count
    
    if @items == 0
        @valuation = 0
    else 
        @valuation = @books.sum(:purchase_price)
    end

    erb :home
end
