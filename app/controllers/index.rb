get '/' do 
    @books = Book.all :order => :id.desc
    puts "[INFO] at / found #{@books.count} books"
    @subhead = 'All items'
    @items = @books.count
    @totalitems = @books.count
    @valuation = @books.sum(:purchase_price)
    puts "[INFO] at / valuation is #{@valuation}"
    erb :home
end
