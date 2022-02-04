require_relative '../lib/create_receipt_app'

RSpec.describe Tax do
    book = LineItem.all.find{|x| x.product === 'book'}
    headache = LineItem.all.find{|x| x.product === 'packet of headache pills'}
    imported_chocolates = LineItem.all.find{|x| x.product === 'imported box of chocolates'}
    perfume = LineItem.all.find{|x| x.product === 'imported bottle of perfume'}

    context 'calculates tax amount for book' do
        it 'evaluates total tax as 0' do
            expect(Tax.new(book).basic_tax).to eq(0)
            expect(Tax.new(book).import_tax).to eq(0)
            expect(Tax.new(book).total).to eq(0)
        end
    end
    context 'calculates tax amount for packet of headache pills' do
        it 'evaluates total tax as 0' do
            expect(Tax.new(headache).basic_tax).to eq(0)
            expect(Tax.new(headache).import_tax).to eq(0)
            expect(Tax.new(headache).total).to eq(0)
        end
    end
    context 'calculates tax amount for packet of imported chocolates' do
        it 'import and total tax as 0.5' do
            expect(Tax.new(imported_chocolates).basic_tax).to eq(0)
            expect(Tax.new(imported_chocolates).import_tax).to eq(0.5)
            expect(Tax.new(imported_chocolates).total).to eq(0.5)
        end
    end
    context 'calculates tax amount for packet of imported chocolates' do
        it 'evaluates total tax as 0' do
            expect(Tax.new(perfume).basic_tax).to eq(4.75)
            expect(Tax.new(perfume).import_tax).to eq(2.4)
            expect(Tax.new(perfume).total).to eq(7.15)
        end
    end
end