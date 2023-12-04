J'ai crée un schéma à partir de mon sujet de mémoire.

Il contient 3 tables :

- phrase_originale : contient des phrases issus d'oeuvres originales
- trad_auto : contient des phrases issus de traductions automatiques
- trad_hum : contient des phrases issus de traductions humaines

chacune de ses tables contient 4 champs :

phrase_originale :

- phrase_id : id, int
- phrase_texte : les phrases, type text
- trad_auto : int
- trad_hum : int

trad_auto :

- trad_auto_id : id, int
- texte_auto : les phrases, type text
- phrase_originale : int
- trad_hum : int

trad_hum :

- trad_hum_id : id, int
- texte_hum : les phrases, type text
- phrase_originale : int
- trad_auto : int

Pour chacune de ces tables, l'id est la clé primaire. Les clés étrangères sont les champs correspondants aux phrases équivalentes dans les autres tables.

Pour l'api, tous les blocs fonctionnent, les requêtes ont été testées avec le logiciel PostMan afin de vérifier leur succès.

Pour l'interface web, deux options permettent soit d'afficher toutes les données, soit d'afficher des données en fonction d'un ID donné en entrée.
En ce qui concerne le diagramme, j'ai eu le même problème que j'avais en classe, je n'arrive pas à les afficher, j'obtiens systématiquement un blanc sans comprendre pourquoi, que ce soit avec bokeh ou matplotlib, j'ai beau essayé divers outils et solutions ça ne fonctionne pas. J'ai laissé le code du diagramme mais j'ai mis le code html correspondant dans un fichier à part puisque ça ne fonctionnait pas.