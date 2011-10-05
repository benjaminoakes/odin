simple_atn
==========

The version of the ATN framework and sample ATN that was produced during prototyping.  I'm happy with how it turned out.  It should be pretty easy on the eyes.  Example function call:

    push(:noun_phrase, position, registers, :into => :object_of_preposition, :next => :prepositional_phrase__noun_phrase)

There's no frontend.  Running `rake` (or `ruby augmented_transition_network_test.rb`, if you don't have rake installed) in the root of this directory will run the unit tests.  I've left a sample parse of the nonsensical sentence 'the monster in the man grows avocados in the street' uncommented so that you can see some output.  You should receive this at the command prompt:

    Loaded suite augmented_transition_network_test
    Started
    ....
    :sentence
        :noun_phrase
            :determiner
            "the"
            :noun
            "monster"
            :prepositional_phrase
                :preposition
                "in"
                :noun_phrase
                    :determiner
                    "the"
                    :noun
                    "man"
        :verb
        "grows"
        :noun_phrase
            :noun
            "avocados"
            :prepositional_phrase
                :preposition
                "in"
                :noun_phrase
                    :determiner
                    "the"
                    :noun
                    "street"
    ..
    Finished in 0.02785 seconds.
    
    6 tests, 48 assertions, 0 failures, 0 errors

The vocabulary of this ATN is quite limited -- see `string.rb`.  I have more in-depth categorization routines in the parent directory -- I didn't see a huge need to include them here -- it would have only taken longer.  Also, the grammar the ATN represents isn't too entirely complicated.  I spent most of my time paring the former code down so that it could be manageable.  At the moment, only noun phrases, prepositional phrases, verb phrases, and (of course) sentences are defined.  The important part is that it handles non_determinism gracefully.  Also of note, the ATN computes the deep structure of passive sentences by the same mechanism as given during class.
