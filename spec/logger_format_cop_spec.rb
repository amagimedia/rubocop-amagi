describe 'PutLoggerFormatCop' do
    describe '#corrector' do
        context 'corrector' do
            let(:source) do
                <<~RUBY.strip
                class Transcode < XMorph::BaseTranscoder
    
                    HIGH_DEFINITION  = "HIGH_DEFINITION".freeze
                  
                    def set_profiles
                      self.profiles = {
                        HIGH_DEFINITION => "/home/root/volt/transcoder -if %{IN} -of %{OUT} -vb 12000000 -vr 1080i60  -acm \"1,2\" -ac \"aac\" -ab 192000 -lt -24 2>&1",
                      }
                    end
                  
                    def set_profile_name
                      self.profile_name = nil
                      mediainfo = self.mediainfo_output
                      width = (mediainfo["Video"]["Original_width"] || mediainfo["Video"]["Width"]).split("pixels")[0].gsub(/ /, "")
                      height = (mediainfo["Video"]["Original_height"] || mediainfo["Video"]["Height"]).split("pixels")[0].gsub(/ /, "")
                      width=width.to_i
                      height=height.to_i
                  
                      res =  "#{width}x#{height}"
                      hd_res_allowed = ["1920x1080", "3840x2160", "2560x1440", "1280x720"]
                  
                      puts("Got Height: #{height}, Width: #{width}")
                  
                      if hd_res_allowed.include? res
                        self.profile_name = HIGH_DEFINITION
                      end
                  
                      unless self.profile_name.nil?
                        puts("Transcode#set_profile_name: using profile #{self.profile_name}")
                        return true
                      end
                  
                      self.error="Got unexpected profile [#{res}]. Expected profiles are #{hd_res_allowed.join(", ")}."
                      return false
                    end
                  end
                  
                RUBY
                let(:processed_source) {parse_source(source)}
                let(:node) { processed_source.ast }
                corrector = described_class.new(processeed_source.buffer)
                puts corrector    
            
            end
            
            
        
        end



    end
end