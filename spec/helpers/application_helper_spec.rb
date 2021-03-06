require "spec_helper"

describe ApplicationHelper, :type => :helper do
  describe "#thumbnail" do
    let(:user) { create(:user, :paul) }
    let(:image) { helper.thumbnail(user) }

    context "with regular expressions" do
      it "returns image" do
        expect(image).to match(%r[<img.*?])
      end

      it "sets url" do
        expect(image).to match(/[efac3492328ff47a6c761063c7cf794a?d=mm]/)
      end

      it "sets alternative text" do
        expect(image).to match(%r[alt="@pyoung"])
      end
    end

    context "with nokogiri" do
      let(:html) { Nokogiri::HTML(image).css("img").first }

      it "returns image" do
        expect(html).not_to be_nil
      end

      it "sets url" do
        expect(html["src"]).to eql("/assets/without_avatar.jpg")
      end

      it "sets alternative text" do
        expect(html["alt"]).to eql("@pyoung")
      end
    end
  end
end