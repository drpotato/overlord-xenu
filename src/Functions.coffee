# Utility functions for use in the game.

class Game.Functions

    @recursive_merge: (object_1, object_2) ->

        for property of object_2
            try

                # Property in destination object set; update it's value.
                if object_2[property].constructor is Object
                    object_1[property] = @recursive_merge(object_1[property], object_2[property])
                else
                    object_1[property] = object_2[property]

            catch e

                # The property in destination object is not set; create it and set it's value.
                object_1[property] = object_2[property]

        return object_1
