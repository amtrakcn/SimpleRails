require 'active_record_lite'

describe "searchable" do
  before(:all) do
    cats_db_file_name =File.expand_path(File.join(File.dirname(__FILE__), "cats.db"))
    DBConnection.open(cats_db_file_name)

    class Cat < SQLObject
      set_table_name("cats")
      my_attr_accessible(:id, :name, :owner_id)
    end

    class Human < SQLObject
      set_table_name("humans")
      my_attr_accessible(:id, :fname, :lname, :house_id)
    end
  end

  # describe "searchable is correctly mixed into SQLObject (extend vs include)" do
  #   class Testing123 < SQLObject
  #     set_table_name "testing"
  #     my_attr_accessible :a, :b, :c
  #   end
  #   Testing123.methods.should include(:where)
  #   t = Testing123.new
  #   t.methods.should_not include(:where)
  # end

  describe "#where" do
    it "returns correct object given a single search term" do
      cat = Cat.where(:name => "Breakfast")[0]
      cat.name.should == "Breakfast"
    end

    it "returns correct object given multiple search terms (Testing AND in WHERE clause.)" do
      human = Human.where(:fname => "Matt", :house_id => 1)[0]
      human.fname.should == "Matt"
    end
  end
end