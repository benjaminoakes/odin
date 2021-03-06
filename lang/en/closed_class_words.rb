module ClosedClassWords
  # Some words from the Ruby Linguistics Project, release 1.0.5
  @@Determiners = ['a', 'an', 'the']
  @@PossesiveAdjectives = %w{my our your his her its their}
  
  @@SingularPronouns = ['i', 'you', 'he', 'she', 'it']
  @@PluralPronouns = ['we', 'you', 'they']
  @@Pronouns = (@@SingularPronouns + @@PluralPronouns).uniq

  #['i', 'we', 'you', 'y\'all', 'he', 'she', 'it', 'they'] # TODO objective forms
    
  @@SingularToPluralPronouns = {
    "i" => "we",
    "you" => "you",
    "he" => "they",
    "she" => "they",
    "it" => "they"
  }
  
  @@Conjunctions = ['and', 'but', 'or', 'as']
  
  # From http://www2.gsu.edu/~wwwesl/egw/verbs.htm
  @@IrregularVerbs = %w{
    awake  	awoke  	awoken
    be 	was were 	been
    bear 	bore 	born
    beat 	beat 	beat
    become 	became 	become
    begin 	began 	begun
    bend 	bent 	bent
    beset 	beset 	beset
    bet 	bet 	bet
    bid 	bid bade 	bid bidden
    bind 	bound 	bound
    bite 	bit 	bitten
    bleed 	bled 	bled
    blow 	blew 	blown
    break 	broke 	broken
    breed 	bred 	bred
    bring 	brought 	brought
    broadcast 	broadcast 	broadcast
    build 	built 	built
    burn 	burned burnt 	burned burnt
    burst 	burst 	burst
    buy 	bought 	bought
    cast 	cast 	cast
    catch 	caught 	caught
    choose 	chose 	chosen
    cling 	clung 	clung
    come 	came 	come
    cost 	cost 	cost
    creep 	crept 	crept
    cut 	cut 	cut
    deal 	dealt 	dealt
    dig 	dug 	dug
    dive 	dived dove 	dived
    do 	did 	done
    draw 	drew 	drawn
    dream 	dreamed dreamt 	dreamed dreamt
    drive 	drove 	driven
    drink 	drank 	drunk
    eat 	ate 	eaten
    fall 	fell 	fallen
    feed 	fed 	fed
    feel 	felt 	felt
    fight 	fought 	fought
    find 	found 	found
    fit 	fit 	fit
    flee 	fled 	fled
    fling 	flung 	flung
    fly 	flew 	flown
    forbid 	forbade 	forbidden
    forget 	forgot 	forgotten
    forego (forgo) 	forewent 	foregone
    forgive 	forgave 	forgiven
    forsake 	forsook 	forsaken
    freeze 	froze 	frozen
    get 	got 	gotten
    give 	gave 	given
    go 	went 	gone
    grind 	ground 	ground
    grow 	grew 	grown
    have  had had
    hang 	hung 	hung
    hear 	heard 	heard
    hide 	hid 	hidden
    hit 	hit 	hit
    hold 	held 	held
    hurt 	hurt 	hurt
    keep 	kept 	kept
    kneel 	knelt 	knelt
    knit 	knit 	knit
    know 	knew 	know
    lay 	laid 	laid
    lead 	led 	led
    leap 	leaped leapt 	leaped leapt
    learn 	learned learnt 	learned learnt
    leave 	left 	left
    lend 	lent 	lent
    let 	let 	let
    lie 	lay 	lain
    light 	lighted lit 	lighted
    lose 	lost 	lost
    make 	made 	made
    mean 	meant 	meant
    meet 	met 	met
    misspell 	misspelled misspelt 	misspelled misspelt
    mistake 	mistook 	mistaken
    mow 	mowed 	mowed mown
    overcome 	overcame 	overcome
    overdo 	overdid 	overdone
    overtake 	overtook 	overtaken
    overthrow 	overthrew 	overthrown
    pay 	paid 	paid
    plead 	pled 	pled
    prove 	proved 	proved proven
    put 	put 	put
    quit 	quit 	quit
    read 	read 	read
    rid 	rid 	rid
    ride 	rode 	ridden
    ring 	rang 	rung
    rise 	rose 	risen
    run 	ran 	run
    saw 	sawed 	sawed sawn
    say 	said 	said
    see 	saw 	seen
    seek 	sought 	sought
    sell 	sold 	sold
    send 	sent 	sent
    set 	set 	set
    sew 	sewed 	sewed sewn
    shake 	shook 	shaken
    shave 	shaved 	shaved shaven
    shear 	shore 	shorn
    shed 	shed 	shed
    shine 	shone 	shone
    shoot 	shot 	shot
    show 	showed 	showed shown
    shrink 	shrank 	shrunk
    shut 	shut 	shut
    sing 	sang 	sung
    sink 	sank 	sunk
    sit 	sat 	sat
    sleep 	slept 	slept
    slay 	slew 	slain
    slide 	slid 	slid
    sling 	slung 	slung
    slit 	slit 	slit
    smite 	smote 	smitten
    sow 	sowed 	sowed sown
    speak 	spoke 	spoken
    speed 	sped 	sped
    spend 	spent 	spent
    spill 	spilled spilt 	spilled spilt
    spin 	spun 	spun
    spit 	spit spat 	spit
    split 	split 	split
    spread 	spread 	spread
    spring 	sprang sprung 	sprung
    stand 	stood 	stood
    steal 	stole 	stolen
    stick 	stuck 	stuck
    sting 	stung 	stung
    stink 	stank 	stunk
    stride 	strod 	stridden
    strike 	struck 	struck
    string 	strung 	strung
    strive 	strove 	striven
    swear 	swore 	sworn
    sweep 	swept 	swept
    swell 	swelled 	swelled swollen 
    swim 	swam 	swum
    swing 	swung 	swung
    take 	took 	taken
    teach 	taught 	taught
    tear 	tore 	torn
    tell 	told 	told
    think 	thought 	thought
    thrive 	thrived throve 	thrived
    throw 	threw 	thrown
    thrust 	thrust 	thrust
    tread 	trod 	trodden
    understand 	understood 	understood
    uphold 	upheld 	upheld
    upset 	upset 	upset
    wake 	woke 	woken
    wear 	wore 	worn
    weave 	weaved wove 	weaved woven
    wed 	wed 	wed
    weep 	wept 	wept
    wind 	wound 	wound
    win 	won 	won
    withhold 	withheld 	withheld
    withstand 	withstood 	withstood
    wring 	wrung 	wrung
    write 	wrote 	written
  }
  
  # Temporarily removed:
  # shoe  shoed   shoed shod
  
  @@Prepositions = ["amid", "at", "but", "by", "down", "from", "in", "into", "like",
    "near", "of", "off", "on", "onto", "out", "over", "past", "with",
    "to", "until", "unto", "up", "upon", "with"]
end