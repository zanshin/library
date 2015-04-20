get '/' do
    @books = Book.all :order => :id.desc
    puts "[INFO] at / found #{@books.count} books"
    @subhead = 'All items'
    @items = @books.count
    @totalitems = @books.count
    puts "[INFO] at / sum(purchase_price) is #{@books.sum(:purchase_price)}"
    @valuation = @books.sum(:purchase_price)
    puts "[INFO] at / valuation is #{@valuation}"
    erb :home
end
