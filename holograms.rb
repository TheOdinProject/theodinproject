## Adds Star Wars like holograms to site.

    Class hologram

        :attr_accessor :type, :gender

        def initialize(type, gender)

            @type = type

            @gender = gender

        end

        def render_image(img)

            live_image(img)

        end

    end