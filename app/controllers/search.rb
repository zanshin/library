get '/search' do
    @books = Book.all(:composer.like => "%#{params[:query]}%") | 
             Book.all(:composition.like => "%#{params[:query]}%") |
             Book.all(:edition.like => "%#{params[:query]}%") |
             Book.all(:type.like => "%#{params[:query]}%")
    @subhead = "Search results for '#{params[:query]}'"
    @items = @books.count
    @allbooks = Book.all
    @totalitems = @allbooks.count
    @valuation = @books.sum(:purchase_price)
    erb :home
end
