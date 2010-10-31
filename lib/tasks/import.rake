# this is pretty nasty stuff, absolutely no refactoring done
namespace :import do 
  desc "import updates from twitter xml dump"
  task :twitter => :environment do
    doc = open("/Users/andybrett/Desktop/tc.xml") { |f| Hpricot(f) }
    tweets = doc.search("//status")
    tweets.each do |update|
      coder = HTMLEntities.new      
      text = update/"text"
      text = coder.decode(text.inner_html)
      text.gsub(/(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?/ix, "")
      handle = text.match /by \@.*/
      if handle
        headline = text.gsub!(handle[0], "")
        handle = handle[0][4..-1]
        author = Author.find_by_handle(handle)
        headline.gsub!(/(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?/ix, "")
        if author
          Headline.create(:text => headline, :author_id => author.id)
        end
      end
    end
  end
end