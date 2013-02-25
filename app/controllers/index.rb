get '/' do 
    @books = Book.all :order => :id.desc
    # puts "found #{@books.count} books"
    @subhead = 'All items'
    @items = @books.count
    @totalitems = @books.count
    @valuation = @books.sum(:purchase_price)
    erb :home
end
