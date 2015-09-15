# shiny-octo-dubstep

Con il termine *Fractal image Compression* si va ad indicare una famiglia di tecniche di compressione di immagini (o video) basate sulle proprietà matematiche dei frattali. Tali metodi di compressione si rivelano sopra ogni altra cosa adatti a comprimere textures e immagini naturali, o, più in generale, immagini che sono caratterizzate da un elevato livello di **self-similarity** (ovvero aventi delle parti che, al netto di rotazioni e ingrandimenti/riduzioni, somigliano ad altre parti dell'immagine).

La compressione di immagini tramite frattali (così come altre, più diffuse, ad esempio *JPEG*) appartiene a quel gruppo di tecniche di compressione *lossy*, ovvero in cui la compressione dell'immagine avviene al costo di una perdita di informazione. Tuttavia, a differenza di quanto accade quando si utilizza uno dei metodi di compressione basati sui pixel (come *JPEG*, *GIF* o *MPEG*), nella compressione frattale nessuna parte dell'immagine viene effettivamente memorizzata. Ciò che viene memorizzato è invece la **struttura interna** dell'immagine (ad esempio un indice di quali parti, effettuate le dovute trasformazioni, sono simili ad altre parti). 

Poiché nessun pixel dell'immagine originale viene memorizzato, la decompressione parte da un singolo pixel, di colore qualsiasi, e procede alla ricostruzione dell'immagine originale applicando iterativamente una mappa ricavata dalla struttura interna dell'immagine originale.

Questo repository contiene:
* un documento relativo tecniche di compressione di immagini basate su frattali
* una implementazione giocattolo realizzata in MATLAB
* alcuni test che consentiranno di valutare praticità e *performances* di una libreria di compressione basata su frattali, anche in confronto con altre tecniche di compressione *lossy* maggiormente utilizzate.

Tutto il materiale presente in questo repository è rilasciato sotto licenza UNIMIAMIB.
