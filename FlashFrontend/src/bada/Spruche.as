import bada.dom.LocalStorage;
/**
 * ...
 * @author tenbits
 */
class bada.Spruche
{
	public static var bookmarkIndex:Number = 0;
	public static var index:Number = 0;
	
	private static var currentIndex:Number = 0;
	private static var bookmarks:Array = [];
	
	public static function get(index:Number):String {
		return spruche[index].spruch;
	}
	
	public static function length():Number {
		return spruche.length;
	}
	
	/**
	 * 
	 * @param	direction
	 * @return [SpruchText, Index, Count]
	 */
	public static function getBookmark(direction:Number):Array {
		if (bookmarks.length == 0) return ['', -1, 0];
		
		if (direction != null){
			if (direction > 0) {
				if (++bookmarkIndex > bookmarks.length - 1) bookmarkIndex = 0;
			}
			if (direction < 0) {
				if (--bookmarkIndex < 0) bookmarkIndex = bookmarks.length - 1;
			}
		}
		
		if (bookmarkIndex > bookmarks.length) bookmarkIndex = 0;
		return [get(bookmarks[bookmarkIndex]), bookmarkIndex, bookmarks.length];
	}
	public static function isBookmark(index:Number):Boolean {
		for (var i:Number = 0; i < bookmarks.length; i++) 
		{
			if (bookmarks[i] == index) return true;
		}
		return false;
	}
	
	public static function removeBookmark(index:Number):Void {
		if (index == null) index = bookmarks[bookmarkIndex];
		for (var i = 0; i < bookmarks.length; i++) {
			if (bookmarks[i]  == index) {
				bookmarks.splice(i, 1);
				bookmarkIndex--;
			}
		}
	}
	
	public static function addBookmark(index:Number):Void {
		if (bookmarks == null) bookmarks = [];
		bookmarks.push(index);
		saveBookmarks();
		if (bookmarkIndex < 0) bookmarkIndex = 0;
	}
	
	private static function saveBookmarks():Void {
		LocalStorage.set('bookmarks', bookmarks);
	}
	
	private static var saveTimeoutBookmarkIndex:Number;
	public static function saveBookmarkIndex():Void {
		if (saveTimeoutBookmarkIndex != null) {
			clearTimeout(saveTimeoutBookmarkIndex);
		}
		saveTimeoutBookmarkIndex = setTimeout(function() {
			LocalStorage.set('bookmarkIndex', Spruche.bookmarkIndex);
			Spruche.saveTimeoutBookmarkIndex = null;
		}, 2000);
	}
	
	public static function restoreBookmarks(callback: Function):Void {
		LocalStorage.get('bookmarks', function(value) {
			if (value instanceof Array) {
				Spruche.bookmarks = value;
				if (callback) callback();
			}
		});
		
		LocalStorage.get('bookmarkIndex', function(value:Number) {
			if (value != null) Spruche.bookmarkIndex = value;
		});
	}
	
	public static var categories:Array = [ {
			label: "all",
			search: '',
			index: 0,
			items: []
		}/*,
		{
			label: "auf dem Oktoberfest",
			search: 'Oktoberfest',
			index: 0,
			items: []
		},
		{
			label: "bei Frauen",
			search: "Frauen",
			index: 0,
			items: []
		},
		{
			label: "bei Männer",
			search: "Männer",
			index: 0,
			items: []
		},
		{
			label: "bei Kollegen",
			search: "Kollegen",
			index: 0,
			items: []
		}*/];
	public static function restoreLastIndexes(callback):Void {
		var indexes = LocalStorage.get('index', function(index:Number) {
			
			if (typeof index == 'number') {
				Spruche.index = index;
			}
			if (callback) callback();
		});
		/*for (var i = 0; i < categories.length; i++) {
			for (var j = 0; j < spruche.length; j++) {
				if (spruche[j].type.indexOf(categories[i].search) > -1) {
					categories[i].items.push(j);
				}
			}
		}*/
	}
	
	private static var saveTimeout:Number;
	public static function saveLastIndexes():Void {
		if (saveTimeout != null) {
			clearTimeout(saveTimeout);
		}
		saveTimeout = setTimeout(function() {
			var indexes = [];
			//for (var i:Number = 0; i < Spruche.categories.length; i++)
				//indexes.push(Spruche.categories[i].index);
			
			LocalStorage.set('index', Spruche.index);
			Spruche.saveTimeout = null;
		}, 1500);
	}
	
	
	private static var spruche:Array = (function() {
		return [{
    spruch: "Aldi hat angerufen, deine Mutter hängt im Drehkreuz fest!"
}, {
    spruch: "Darf ich deine Mutter mal bitte ausleihen? Ich brauch noch was Dickes mit Bart für Weihnachten."
}, {
    spruch: "Deine Mutter fragt bei Amazon nach der Kundentoilette."
}, {
    spruch: "Das Erste, was deine Mutter bei den Anonymen Alkoholikern sagt, ist ihr Name, Adresse und Telefonnummer."
}, {
    spruch: "Das Haus deiner Mutter ist so dreckig, sie muss sich die Füße abtreten, wenn sie rausgeht!"
}, {
    spruch: "Deine Eltern sind zwei nette Kerle."
}, {
    spruch: "Deine Mutter kann nen Panzer kickstarten!"
}, {
    spruch: "Deine Mutter arbeitet bei der Marine - als Flugzeugträger."
}, {
    spruch: "Deine Mutter bellt wenns klingelt!"
}, {
    spruch: "Deine Mutter bestellt Pizza bei Ebay. "
}, {
    spruch: "Deine Mutter bestellt sich DSL Light um abzunehmen."
}, {
    spruch: "Deine Mutter bezahlt ihre Miete mit Pfandflaschen!"
}, {
    spruch: "Deine Mutter bindet sich einen Autoreifen auf den Rücken und denkt sie wär ein Transformer."
}, {
    spruch: "Deine Mutter blockt deinen Vater in MSN und ICQ!"
}, {
    spruch: "Deine Mutter brät Pommes auf der Heizung!"
}, {
    spruch: "Deine Mutter campt vor Spar, weil es dort Wurst im Sonderangebot gibt."
}, {
    spruch: "Deine Mutter chattet mit Boxhandschuhen"
}, {
    spruch: "Deine Mutter disst einen Stein und der Stein gewinnt."
}, {
    spruch: "Deine Mutter fährt den Bus vom A-Team."
}, {
    spruch: "Deine Mutter faltet Tüten Bei Aldi!"
}, {
    spruch: "Deine Mutter geht in den Apple-Laden und will Obst kaufen!"
}, {
    spruch: "Deine Mutter geht in den Park und frisst den Enten das Brot weg!"
}, {
    spruch: "Deine Mutter geht zu \"Wer wird Millionär\" nur um ein Glas Wasser zu trinken!"
}, {
    spruch: "Deine Mutter geht zu \"Wer wird Millionär\" und benutzt den Telefonjoker um kurz umsonst mit deinem Vater telefonieren zu können."
}, {
    spruch: "Deine Mutter geht zum Vorstellungsgespräch und singt: \"Arbeit nervt!\""
}, {
    spruch: "Deine Mutter glaubt, sie wär MacGyver, springt ausm Flugzeug, klebt ein Kaugummi an die Alditüte und kracht wie ein nasser Sack aufn Boden."
}, {
    spruch: "Deine Mutter hat angerufen, du sollst nach Hause kommen und ihr den Rücken kämmen."
}, {
    spruch: "Deine Mutter hat angerufen. Du sollst deinen Vater vom Ballett holen."
}, {
    spruch: "Deine Mutter hat Bart, Glatze und kann nicht kochen."
}, {
    spruch: "Deine Mutter hat Blutgruppe: Schmalz."
}, {
    spruch: "Deine Mutter hat drei Arme und lacht über Behinderte."
}, {
    spruch: "Deine Mutter hat ein Arm und will in einen \"Second Hand Shop\"."
}, {
    spruch: "Deine Mutter hat Glatze und fährt Panzer!"
}, {
    spruch: "Deine Mutter hat Homezone auf der Reeperbahn."
}, {
    spruch: "Deine Mutter hat keine Löcher in den Socken, sondern nen Socken im Loch."
}, {
    spruch: "Deine Mutter hat mehr unbezahlte Rechnungen wie Max Mustermann!"
}, {
    spruch: "Deine Mutter hat nen neuen Job bei Lidl, sie sitzt im Leergutautomaten und säuft die Reste aus!"
}, {
    spruch: "Deine Mutter hat nen Vollbart und ist die Stärkste im Knast!"
}, {
    spruch: "Deine Mutter hat nur ein Bein und wünscht sich einen Kickroller!"
}, {
    spruch: "Deine Mutter hat nur noch einen Zahn und dein Vater benutzt sie als Flaschenöffner."
}, {
    spruch: "Deine Mutter hat Schulden im 1-Euro-Shop!"
}, {
    spruch: "Deine Mutter hat so heftig behaarte Achseln, dass man denkt sie hat zwei Hippies im Schwitzkasten!"
}, {
    spruch: "Deine Mutter hatte Sex mit allen vier Ludolfs!"
}, {
    spruch: "Deine Mutter heißt Gollum und will ihren Ehering wieder!"
}, {
    spruch: "Deine Mutter heißt Pablo und ist Mitglied in einer Straßen-Gang."
}, {
    spruch: "Deine Mutter heißt Udo und züchtet Schweine."
}, {
    spruch: "Deine Mutter heißt Ulf und fährt Bagger."
}, {
    spruch: "Deine Mutter klaut sogar Freibier!"
}, {
    spruch: "Deine Mutter isst Fischbrötchen, belegt mit Moby Dick!"
}, {
    spruch: "Deine Mutter isst Kürbisjoghurt mit ganzen Früchten."
}, {
    spruch: "Deine Mutter ist das Leibgericht von Hannibal Lector im XXL-Restaurant!"
}, {
    spruch: "Deine Mutter ist der BESTE!"
}, {
    spruch: "Deine Mutter ist der Endgegner bei \"Ich bin ein Star holt mich hier raus!\""
}, {
    spruch: "Deine Mutter ist der Fehler in der Matrix."
}, {
    spruch: "Deine Mutter ist die haarigste im Zoo!"
}, {
    spruch: "Deine Mutter ist die Kulisse von Starlight-Express"
}, {
    spruch: "Deine Mutter ist ein trojanisches Pferd. 70 Männer passen rein."
}, {
    spruch: "Deine Mutter ist Platin gegangen. Sie wurde mehr als 1.000.000-mal verkauft."
}, {
    spruch: "Deine Mutter ist Preisboxer aufm Jahrmarkt!"
}, {
    spruch: "Deine Mutter ist so alt, sie hat die Handynummer von Jesus."
}, {
    spruch: "Deine Mutter ist so alt, die ist als Kind mit der Pferdekutsche zur Schule gefahren!"
}, {
    spruch: "Deine Mutter ist so arm, die beantragt Hartz IV bei Monopoly!"
}, {
    spruch: "Deine Mutter ist so arm, ihr Lieferservice sind \"Die Tafeln\"!"
}, {
    spruch: "Deine Mutter ist so arm, sie hängt benutztes Toilettenpapier zum Trocknen auf!"
}, {
    spruch: "Deine Mutter ist so arm, wenn sie um den Teich geht, schmeißen die Enten Brotkrümel!"
}, {
    spruch: "Deine Mutter hält Recycling für eine olympische Sportart."
}, {
    spruch: "Deine Mutter ist so dick, dass sie einen Spiegel braucht um ihre Schuhe zu zumachen!"
}, {
    spruch: "Deine Mutter ist so dick, sie sitzt sogar im Stehen!"
}, {
    spruch: "Deine Mutter ist so doof, sie verläuft sich im leeren Raum!"
}, {
    spruch: "Deine Mutter wird öfter über den Tisch gezogen als ein Putzlappen."
}, {
    spruch: "Deine Mutter ist so dumm, die bezahlt bei \"All You Can Eat\" 2-mal!"
}, {
    spruch: "Deine Mutter ist so dumm, sie dreht sogar die Quadrate bei Tetris!"
}, {
    spruch: "Deine Mutter hat nen Brennholzverleih aufgemacht!"
}, {
    spruch: "Deine Mutter kauft sich einen Kühlschrank und denkt sie wär cool."
}, {
    spruch: "Deine Mutter klaut Gratis-Proben bei Douglas!"
}, {
    spruch: "Deine Mutter ist so dumm, die lässt sich von einem parkendem Auto überfahren. "
}, {
    spruch: "Deine Mutter lässt sogar Wasser anbrennen."
}, {
    spruch: "Deine Mutter lutscht Klosteine, weil sie denkt das wären Bonbons!"
}, {
    spruch: "Deine Mutter schminkt sich mit Edding!"
}, {
    spruch: "Deine Mutter trifft nicht mal, wenn sie einen Stein auf den Boden werfen will."
}, {
    spruch: "Neben deiner Mutter sehen Beavis & Butthead wie Nobelpreisträger aus."
}, {
    spruch: "Deine Mutter ist so dumm, sie dachte \"Boys II Men\" sei eine Kindertagesstätte."
}, {
    spruch: "Deine Mutter denkt beim 1x1 an Buchstabensuppe!"
}, {
    spruch: "Deine Mutter ist so dumm, sie fragt dich sogar \"wie ist die Nummer der 110?\""
}, {
    spruch: "Deine Mutter guckt bei einer Glastür durchs Schlüsselloch!"
}, {
    spruch: "Deine Mutter hat versucht M&Ms alphabetisch zu ordnen."
}, {
    spruch: "Deine Mutter isst die Suppe mit der Gabel."
}, {
    spruch: "Deine Mutter ist so dumm, sie ist in einem Supermarkt eingesperrt worden und verhungerte."
}, {
    spruch: "Deine Mutter kauft sich Internet ohne einen PC!"
}, {
    spruch: "Deine Mutter kaufte sich ein solarbetriebenes Flash-Light!"
}, {
    spruch: "Deine Mutter kaufte sich eine Videokamera um Filme im Fernsehen aufzunehmen"
}, {
    spruch: "Deine Mutter kocht Wasser nach Rezept."
}, {
    spruch: "Deine Mutter läuft bei Super Mario nach links!"
}, {
    spruch: "Deine Mutter ist so dumm, sie sitzt auf dem Fernseher und guckt aufs Sofa!"
}, {
    spruch: "Deine Mutter ist so dumm, sie stahl kostenloses Brot."
}, {
    spruch: "Deine Mutter verhütet mit der Glücksspirale."
}, {
    spruch: "Deine Mutter versucht gerade Linien mit einer Zick-Zack-Schere zu schneiden."
}, {
    spruch: "Deine Mutter wollte den Bus 240 nehmen und nahm stattdessen den Bus 120 zweimal!"
}, {
    spruch: "Wenn Mutter das \"FSK ab 18\"-Schild liest, lädt sie sich erst mal 17 Freunde ein um den Film zu sehen! "
}, {
    spruch: "Deine Mutter ist so dick das drei weitere dicke Mütter in ihrer Umlaufbahn kreisen!"
}, {
    spruch: "Deine Mutter ist so dick, als ich versuchte um sie herum zu fahren hat mein Sprit nicht gereicht."
}, {
    spruch: "Deine Mutter ist so dick, als sie auf dem Marktplatz stand wurde sie wegen Illegaler Massenversammlung verhaftet!"
}, {
    spruch: "Deine Mutter ist so dick, als sie Bungee-Jumping machte hat sie die Brücke abgerissen!"
}, {
    spruch: "Deine Mutter ist so dick, als sie in den Grand Canyon fiel, blieb sie stecken!"
}, {
    spruch: "Deine Mutter ist so dick, Armstrong hat ihr eine Flagge in den Hintern gesteckt!"
}, {
    spruch: "Deine Mutter ist so dick, bei Google-Earth, Google Maps und Google Streetview versperrt sie einem die Sicht!"
}, {
    spruch: "Deine Mutter ist so dick, dass die Wale im Meer \"We are Family\" singen wenn sie schwimmen geht."
}, {
    spruch: "Deine Mutter ist so dick, dass man nur im Plural von ihr spricht."
}, {
    spruch: "Deine Mutter ist so dick, dass McDonald´s sie als Werbefläche mieten will."
}, {
    spruch: "Deine Mutter ist so dick, dass sie als Geheimtipp für Bergsteiger gilt."
}, {
    spruch: "Deine Mutter ist so dick, dass sie ihre eigene Postleitzahl hat."
}, {
    spruch: "Deine Mutter ist so dick, die einzigen Bilder von ihr sind von einem Satelliten aus aufgenommen worden."
}, {
    spruch: "Deine Mutter hat Alzheimer-Bulimie - sie frisst den ganzen Tag und vergisst abends zu kotzen!"
}, {
    spruch: "Deine Mutter hat die Blutgruppe Nutella positiv."
}, {
    spruch: "Deine Mutter ist Türsteher bei McDonalds!"
}, {
    spruch: "Deine Mutter ist so dick, die Nationale Wetteragentur muss Namen für ihre Fürze erfinden."
}, {
    spruch: "Deine Mutter steht am Strand und verkauft Schatten."
}, {
    spruch: "Deine Mutter trägt den heiligen BH. Wenn du den hinten öffnest dann fallen vorne zwei auf die Knie!"
}, {
    spruch: "Für deine Mutter ist Bratensoße ein Erfrischungsgetränk!"
}, {
    spruch: "Deine Mutter ist so dick, ihr Bauch ist per Überhangmandat in den Bundestag eingezogen!"
}, {
    spruch: "Deine Mutter ist so dick, ihr Ehering wurde in einem Pizzakarton geliefert. "
}, {
    spruch: "Deine Mutter ist so dick, ihr Gürtel ist der Äquator."
}, {
    spruch: "Deine Mutter ist so dick, ihr Nacken sieht aus wie zwei Hot-Dogs!"
}, {
    spruch: "Die Fürze deiner Mutter sind Schuld an der globalen Erwärmung."
}, {
    spruch: "Deine Mutter ist so dick, jedes Navigationssystem in Ihrer Nähe sucht eine alternative Route, wenn Sie auf der Straße geht!"
}, {
    spruch: "Deine Mutter ist so dick, Leute joggen zum Training um sie herum."
}, {
    spruch: "Deine Mutter ist so dick, man braucht ein Flugzeug um an das andere Ende zu kommen!"
}, {
    spruch: "Deine Mutter ist so dick, man muss den Türrahmen einfetten und einen Keks ins Zimmer legen nur damit man sie rein bekommt!"
}, {
    spruch: "Deine Mutter ist so dick, obwohl sie die einzige in ihrer Fraktion im Bundestag ist, hat sie die absolute Mehrheit."
}, {
    spruch: "Deine Mutter ist so dick, sie arbeitet als Gegengewicht im Aufzug."
}, {
    spruch: "Deine Mutter ist so dick, sie benutzt ein Zirkusszelt als Tanga!"
}, {
    spruch: "Deine Mutter ist so dick, sie benutzt eine Matratze als Tampon!"
}, {
    spruch: "Deine Mutter ist so dick, sie braucht einen Bumerang um sich den Gürtel umzuschnallen."
}, {
    spruch: "Deine Mutter ist so dick, sie fiel hin und schuf den Grand Canyon!"
}, {
    spruch: "Deine Mutter ist so dick, sie ging in ein Restaurant, guckte sich die Speisekarte an und sagte: \"Okay!\"."
}, {
    spruch: "Deine Mutter ist so dick, sie ging ins Kino und saß neben jedem!"
}, {
    spruch: "Deine Mutter ist so dick, sie ging über die 4th Avenue und landete auf der 9th."
}, {
    spruch: "Deine Mutter ist so dick, sie hat Blutgruppe Frittenfett!"
}, {
    spruch: "Deine Mutter hat eine Laufmasche in ihrer Jeans!"
}, {
    spruch: "Deine Mutter ist so dick, sie ist jetzt Naturschutzgebiet für Falken geworden."
}, {
    spruch: "Deine Mutter ist so dick, sie kann den Mond ersetzen!"
}, {
    spruch: "Deine Mutter ist so dick, sie liegt am Strand und keiner bekommt Sonne."
}, {
    spruch: "Deine Mutter ist so dick, sie macht Passbilder bei Google-Earth!"
}, {
    spruch: "Deine Mutter ist so dick, sie muss sich ihre Hosen auf der Straße bügeln."
}, {
    spruch: "Deine Mutter ist so dick, sie muss zwei Flugtickets kaufen"
}, {
    spruch: "Deine Mutter ist so dick, sie musste ins Aqua-Land gehen um getauft zu werden!"
}, {
    spruch: "Deine Mutter ist so dick, sie mussten die Badewanne einfetten um sie wieder herauszubekommen."
}, {
    spruch: "Deine Mutter ist so dick, sie piepst beim Rückwärtsgehen!"
}, {
    spruch: "Deine Mutter ist so dick, sie saß am Strand und Greenpeace schmiss sie ins Meer."
}, {
    spruch: "Deine Mutter ist so dick, sie sitzt überall bequem!"
}, {
    spruch: "Deine Mutter ist so dick, sie sprang in den Ozean und Spanien dankte ihr für die neue Welt."
}, {
    spruch: "Deine Mutter ist so dick, sie sprang in die Luft und blieb stecken!"
}, {
    spruch: "Deine Mutter ist so dick, sie steht immer in zwei Zeitzonen!"
}, {
    spruch: "Deine Mutter ist so dick, sie wacht in Teilen auf."
}, {
    spruch: "Deine Mutter ist so dick, sie wird im Falle eines Kometeneinschlages von der Regierung als Schutzschild benutzt."
}, {
    spruch: "Deine Mutter ist so dick, sie wollte ein Bad nehmen, aber das Wasser floh vor ihr."
}, {
    spruch: "Deine Mutter ist so dick, sie wurde im Meer getauft!"
}, {
    spruch: "Deine Mutter ist so dick, sie zählt als eigenes Sonnensystem!"
}, {
    spruch: "Deine Mutter ist so dick, sogar Chuck Norris hat vor ihr Respekt!"
}, {
    spruch: "Deine Mutter ist so dick, wenn deine Mutter vom Hochhaus springt, singt Massiv: \"Wenn der Mond in mein Ghetto kracht!\""
}, {
    spruch: "Deine Mutter ist so dick, wenn sie aus dem Haus geht denken alle es ist Sonnenfinsternis!"
}, {
    spruch: "Deine Mutter ist so dick, wenn Sie auf dem Bauch liegt, bekommt sie Höhenangst!"
}, {
    spruch: "Deine Mutter ist so dick, wenn sie einen gelben Regenmantel an hat, rufen alle \"Taxi!\""
}, {
    spruch: "Deine Mutter ist so dick, wenn sie Fußball spielt, steht sie immer im Aus."
}, {
    spruch: "Deine Mutter ist so dick, wenn sie geht löst sie Autoalarmanlagen aus."
}, {
    spruch: "Deine Mutter ist so dick, wenn sie Hustet entstehen Tornados!"
}, {
    spruch: "Deine Mutter ist so dick, wenn sie ihre Handtasche von rechts nach links wechseln will, muss sie sie werfen!"
}, {
    spruch: "Deine Mutter ist so dick, wenn sie in Japan im Urlaub im Meer schwimmt, machen die Waljäger Jagd auf sie."
}, {
    spruch: "Deine Mutter ist so dick, wenn Sie nach Hause kommt, wird es zwei Stunden vorher schon dunkel!"
}, {
    spruch: "Deine Mutter ist so dick, wenn sie sich auf die Waage stellt sieht sie da meine Handynummer! "
}, {
    spruch: "Deine Mutter ist so dick, wenn sie sich auf die Wage stellt, steht da \"Fortsetzung folgt\"!"
}, {
    spruch: "Deine Mutter ist so dick, wenn sie sich auf eine Waage stellt, steht \"Bitte einer nach dem anderen\" drauf."
}, {
    spruch: "Deine Mutter ist so dick, wenn sie von einem Bus angefahren wird, sagt sie: \"Wer hat den Stein geworfen?\""
}, {
    spruch: "Deine Mutter ist so dick, wir sind gerade in ihr drin!"
}, {
    spruch: "Deine Mutter macht 12 Diäten gleichzeitig, denn von einer alleine wird sie nicht satt."
}, {
    spruch: "Deine Mutter ist so geizig, wenn sie kotzt presst sie die Zähne zusammen um die Bröckchen nicht herzugeben."
}, {
    spruch: "Deine Mutter ist so haarig, die einzige Sprache die sie kann ist Wookie."
}, {
    spruch: "Deine Mutter ist so hässlich, das sie Verhütungsmittel umsonst kriegt."
}, {
    spruch: "Deine Mutter ist so hässlich, dein Vatter nimmt sie mit zur Arbeit damit er ihr keinen Abschiedskuss geben muss."
}, {
    spruch: "Deine Mutter ist so hässlich, die braucht für ihr Gesicht einen Waffenschein. "
}, {
    spruch: "Deine Mutter ist so hässlich, man gab ihr kein Kostüm als sie sich für \"Star Wars\" bewarb!"
}, {
    spruch: "Deine Mutter ist so hässlich, sie hat Medusa in Stein verwandelt."
}, {
    spruch: "Deine Mutter ist so hässlich, sie wollte bei einem Hässlichkeitscontest mitmachen, aber die Organisatoren sagten: \"Sorry, keine Profis!\""
}, {
    spruch: "Deine Mutter fragt den Vibrator, warum er so zittert."
}, {
    spruch: "Deine Mutter ist Statist und spielt den Todesstern in Star Wars!"
}, {
    spruch: "Deine Mutter ist Suchergebnis 1-156 bei Youporn."
}, {
    spruch: "Deine Mutter ist unbeliebter als Windows Vista!"
}, {
    spruch: "Deine Mutter ist wie ein Buffet, für 5 EUR all you can eat!"
}, {
    spruch: "Deine Mutter ist wie ein Cheeseburger. FETTIG und kostet 1 EURO!"
}, {
    spruch: "Deine Mutter ist wie ein Eichhörnchen, sie muss ständig Nüsse im Mund haben."
}, {
    spruch: "Deine Mutter ist wie ein Formel-1-Pilot, sie verbrennt 50 Gummis pro Tag!"
}, {
    spruch: "Deine Mutter ist wie ein Moskito, man muss sie schlagen, damit sie aufhört zu saugen!"
}, {
    spruch: "Deine Mutter ist wie ein Nintendo DS. Anfassen und spielen."
}, {
    spruch: "Deine Mutter ist wie ein Päckchen Böller, für einen Euro kanns man sie fünf mal knallen!"
}, {
    spruch: "Deine Mutter ist wie ein Senfglas, jeder darf sein Würstchen reinstecken."
}, {
    spruch: "Deine Mutter ist wie ein Sexshop. Keiner will es zugeben, aber jeder war schon mal drin!"
}, {
    spruch: "Deine Mutter ist wie ein Sofa, da darf jeder mal drauf liegen."
}, {
    spruch: "Deine Mutter ist wie ein Staubsauger, sie saugt, bläst und liegt im Schrank."
}, {
    spruch: "Deine Mutter ist wie ein Taxi. Sie hat immer einen hinten drin."
}, {
    spruch: "Deine Mutter ist wie eine Treppe, sie lässt sich von jedem besteigen. "
}, {
    spruch: "Deine Mutter ist wie Homer Simpson: dick, versoffen und hat jeden Tag das gleiche an."
}, {
    spruch: "Deine Mutter kackt vorm Aldi, weil auf der Tür steht: \"Bitte drücken\""
}, {
    spruch: "Deine Mutter kann bei Lordi mitsingen - ohne Maske!"
}, {
    spruch: "Deine Mutter kauft Anziehsachen bei Obi!"
}, {
    spruch: "Deine Mutter kennt man aus \"Bauer sucht Frau\"!"
}, {
    spruch: "Deine Mutter kippt Actimel über den PC, um ihn vor Viren zu schützen!"
}, {
    spruch: "Deine Mutter klaut Ballons beim Luftballon-Gratis-Tag!"
}, {
    spruch: "Deine Mutter klaut bei Kik und verlangt nach dem Kassenzettel."
}, {
    spruch: "Deine Mutter klaut bei McDonalds die Strohhalme."
}, {
    spruch: "Deine Mutter klaut Probiersöckchen bei Deichmann!"
}, {
    spruch: "Deine Mutter kloppt sich mit Enten ums Brot!"
}, {
    spruch: "Deine Mutter lacht über \"Deine Mutter\"-Witze."
}, {
    spruch: "Deine Mutter legt Tarotkarten auf 9Live!"
}, {
    spruch: "Deine Mutter lispelt beim Chatten!"
}, {
    spruch: "Deine Mutter lutscht Klosteine!"
}, {
    spruch: "Deine Mutter macht das Essen mit dem Fön warm."
}, {
    spruch: "Deine Mutter macht hinter Penny Armdrücken um die Pfandflaschen."
}, {
    spruch: "Deine Mutter macht im Aldi den Einkaufswagen voll, rennt zur Kasse und sagt: \"Zum hier Essen.\""
}, {
    spruch: "Deine Mutter macht Kniebeugen im Gurkenfeld"
}, {
    spruch: "Deine Mutter macht mehr Dreier als BMW!"
}, {
    spruch: "Deine Mutter macht sich ein Stirnband um und denkt sie wär Rambo!"
}, {
    spruch: "Deine Mutter macht Telefonstreiche bei 9live."
}, {
    spruch: "Deine Mutter nimmt ne Fernbedienung mit ins Kino, damit sie umschalten kann."
}, {
    spruch: "Deine Mutter nutzt den Telefonjoker um zu fragen, welche Farbe das weiße Haus hat."
}, {
    spruch: "Deine Mutter packt ihr Gesicht aufm Grill und ruft: \"Don´t call it Schnitzel!\""
}, {
    spruch: "Deine Mutter gießt Seerosen."
}, {
    spruch: "Deine Mutter raspelt Kokosnüsse bei Bounty."
}, {
    spruch: "Deine Mutter rennt in den Zoo und bewirft die Affen mit Kot."
}, {
    spruch: "Deine Mutter säuft so viel, sie wird in der Jahresbilanz der Brauerei Oettinger namentlich erwähnt."
}, {
    spruch: "Deine Mutter schiebt sich nen Fisch hinten rein und behauptet, sie wäre ne Meerjungfrau."
}, {
    spruch: "Deine Mutter schmuggelt deutsche Kippen nach Polen!"
}, {
    spruch: "Deine Mutter schmuggelt kiloweise Gras nach Holland."
}, {
    spruch: "Deine Mutter schreit im Gartencenter bei Obi: \"Ich bin ein Star holt mich hier raus!\", weil sie denkt, sie wär im Dschungel-Camp gelandet."
}, {
    spruch: "Deine Mutter schreit in der Öffentlichkeit: \"Ich bin doof!\""
}, {
    spruch: "Deine Mutter schwänzt die Arbeit und zockt bei Saturn Playstation!"
}, {
    spruch: "Deine Mutter schwitzt beim Kacken!"
}, {
    spruch: "Deine Mutter schwitzt beim Toasten."
}, {
    spruch: "Deine Mutter singt \"Mein Block\" von Sido und zeigt dabei auf 5 Mülltonnen."
}, {
    spruch: "Deine Mutter sitzt bei Aldi unter der Kasse und macht \"piiep\"!"
}, {
    spruch: "Deine Mutter sitzt im Cola-Automat und gibt Wechselgeld."
}, {
    spruch: "Deine Mutter sortiert die Wühlkiste bei KIK!"
}, {
    spruch: "Deine Mutter spielt \"Sims 2\" und meint, es sei ein Killerspiel."
}, {
    spruch: "Deine Mutter spielt alleine Karten und schummelt!"
}, {
    spruch: "Deine Mutter spielt Schach ohne Figuren."
}, {
    spruch: "Deine Mutter spielt sich an den Brüsten und sagt \"Man, hab ich dicke Eier\"!"
}, {
    spruch: "Deine Mutter spuckt kleine Kinder an und schreit \"AQUAKNARRE!\""
}, {
    spruch: "Deine Mutter stampft den Wein fürs Tetra-Pack."
}, {
    spruch: "Deine Mutter steht in der Dönerbude und dreht sich!"
}, {
    spruch: "Deine Mutter steht vor Aldi und trinkt Würstchenwasser!"
}, {
    spruch: "Deine Mutter steht vor KIK und ruft: \"Ich bin billiger!\""
}, {
    spruch: "Deine Mutter steht vor Plus und fragt, wo Minus ist!"
}, {
    spruch: "Deine Mutter stellt sich neben 2 Mülltonnen und sagt: \"Cheeesseee\"!"
}, {
    spruch: "Deine Mutter riecht nach Wirsing."
}, {
    spruch: "Deine Mutter stürzt öfters ab als Windows!"
}, {
    spruch: "Deine Mutter sucht nach Sonderangeboten im 55-Cent-Markt!"
}, {
    spruch: "Deine Mutter sucht nen Mann mit Pferdeschwanz. Frisur egal."
}, {
    spruch: "Deine Mutter tanzt bei Aldi auf der Tiefkühltruhe und denkt sie ist bei \"Dancing on Ice\"!"
}, {
    spruch: "Deine Mutter trägt 20 Zoll-Felgen als Ohrringe."
}, {
    spruch: "Deine Mutter trägt einen Tanga auf dem Kopf und denkt sie wäre 2Pac!"
}, {
    spruch: "Deine Mutter verheddert sich im schnurlosen Telefon!"
}, {
    spruch: "Deine Mutter verkauft ihre Fingernägel als Bumerang."
}, {
    spruch: "Deine Mutter verläuft sich in der Telefonzelle."
}, {
    spruch: "Deine Mutter versucht bei Tetris den höchsten Turm zu bauen."
}, {
    spruch: "Deine Mutter versucht einen Fisch zu ertränken!"
}, {
    spruch: "Deine Mutter versucht ihre Weihnachtsgeschenke mit Winrar zu verpacken."
}, {
    spruch: "Deine Mutter versucht im Chat mit der Leertaste zu spammen."
}, {
    spruch: "Deine Mutter wettet auf England bei der WM!"
}, {
    spruch: "Deine Mutter will ins Gefängnis einbrechen."
}, {
    spruch: "Deine Mutter wird öfter gegrapscht als ein Touchscreen."
}, {
    spruch: "Deine Mutter wird öfters geknallt als die Tür vom Arbeitsamt!"
}, {
    spruch: "Deine Mutter wirft eine Orange auf den Boden und schreit \"LOS PIKATCHU!\""
}, {
    spruch: "Deine Mutter wirft einen Vogel aus dem Fenster, um ihn zu töten!"
}, {
    spruch: "Deine Mutter wohnt im Erdgeschoss und fährt mit dem Aufzug."
}, {
    spruch: "Deine Mutter wollte dich eigentlich nach deinem Erzeuger benennen, aber GANGBANG ist ein blöder Name!"
}, {
    spruch: "Deine Mutter wünscht all ihren Freiern ein frohes neues Jahr."
}, {
    spruch: "Deine Mutter zahlt die Miete mit Pfandflaschen und kocht auf der Heizung!"
}, {
    spruch: "Deine Mutter zeigt, wer der Mann im Haus ist!"
}, {
    spruch: "Deine Mutter zerreißt Telefonbücher bei 'Wetten dass'!"
}, {
    spruch: "Deine Mutter zieht Lastwagen auf DSF!"
}, {
    spruch: "Deine Mutter zockt Counter Strike mit nem Lenkrad."
}, {
    spruch: "Der Lebensgefährte deiner Mutter heißt Johnny Walker."
}, {
    spruch: "Du stehst am Muttertag mit Blumen auf der Reeperbahn!"
}, {
    spruch: "Ey, deine Mutter hat mehr Pilze als Super Mario Land."
}, {
    spruch: "Hast Du schon gehört, wer auseinander ist? Die Zähne deiner Mutter."
}, {
    spruch: "Ich hab letztens in einer Tierdoku deine Mutter gesehen, wie sie eine Herde Büffel gerissen hat."
}, {
    spruch: "Jeder hat das Recht hässlich zu sein. Aber deine Mutter übertreibt!"
}, {
    spruch: "McDonalds hat angerufen, deine Mutter steckt in der Rutsche fest."
}, {
    spruch: "Über dem Niveau deiner Mutter ist neulich ne Kellerwohnung freigeworden!"
}, {
    spruch: "Was ist der Unterschied zwischen deiner Mutter und einer Pizza? Pizza gibt es auch ohne Pilze!"
}, {
    spruch: "Was ist der Unterschied zwischen Holz und deiner Mutter? Ganz einfach: Holz arbeitet!"
}, {
    spruch: "Wenn deine Mutter atmet, stößt sie 2-mal so viel CO2 aus wie USA und China in einem Jahr."
}, {
    spruch: "Wenn deine Mutter auf einem Trampolin springt, gibt es eine Sonnenfinsternis!"
}, {
    spruch: "Wenn deine Mutter ein Taxi bestellt, kommt die Müllabfuhr vorbei!"
}, {
    spruch: "Wenn deine Mutter ins Weltall fliegt, haben wir einen zweiten Mond."
}, {
    spruch: "Wenn deine Mutter läuft, gibt es in China ein Erdbeben!"
}, {
    spruch: "Wenn deine Mutter morgens in einem gelben T-shirt den Berg hoch läuft, denkt man die Sonne geht auf."
}, {
    spruch: "Wenn die Bahn streikt zieht deine Mutter die Züge."
}, {
    spruch: "Deine Mutter ist so unwichtig, sie bekommt nicht mal Spam-Mail!"
}];
		}).apply(Spruche);
	
}