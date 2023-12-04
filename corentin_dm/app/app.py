from flask import Flask, render_template, request, Response
import mysql.connector
import matplotlib.pyplot as plt
import io
import base64

# l'application
app = Flask(__name__)

# la connexion
db = mysql.connector.connect(
    host="localhost",
    user='root',
    password='fLON111427!',
    database='corentin_lgp_dm'
)
cursor = db.cursor()

# le chemin de base qui permet d'accéder à toutes les données
@app.route('/', methods=['GET', 'POST'])  
def index():
    if request.method == 'POST':
        try:
            # on établit une connexion
            connexion = db
            cursor = connexion.cursor() # on ouvre le curseur

            # on récupère les données de chaque table
            cursor.execute('SELECT * FROM phrase_originale')
            phrase_originale_data = cursor.fetchall()

            cursor.execute('SELECT * FROM trad_auto')
            trad_auto_data = cursor.fetchall()

            cursor.execute('SELECT * FROM trad_hum')
            trad_hum_data = cursor.fetchall()

            # on transmet les données au template
            return render_template('index.html',
                                   phrase_originale=phrase_originale_data,
                                   trad_auto=trad_auto_data,
                                   trad_hum=trad_hum_data)

        except mysql.connector.Error as error: # on gère les erreurs
            print("Error connecting to MySQL:", error)
            return "Error connecting to MySQL"

    # si la méthode est 'GET' :
    return render_template('index.html',
                           phrase_originale=[],
                           trad_auto=[],
                           trad_hum=[])

# un chemin qui permet de chercher des données spécifiques en fonction de l'ID
@app.route('/chercher', methods=['GET', 'POST'])
def chercher():
    if request.method == 'POST':
        les_criteres = request.form['les_criteres']

        if les_criteres:
            try:
                # Use context manager to handle cursor and connection
                with db.cursor() as cursor:
                    # Fetch data from tables based on search criteria
                    cursor.execute("SELECT * FROM phrase_originale WHERE phrase_id = %s", (les_criteres,))
                    phrase_originale_data = cursor.fetchall()

                    cursor.execute("SELECT * FROM trad_auto WHERE trad_auto_id = %s", (les_criteres,))
                    trad_auto_data = cursor.fetchall()

                    cursor.execute("SELECT * FROM trad_hum WHERE trad_hum_id = %s", (les_criteres,))
                    trad_hum_data = cursor.fetchall()

                return render_template('index.html',
                                       phrase_originale=phrase_originale_data,
                                       trad_auto=trad_auto_data,
                                       trad_hum=trad_hum_data)
            
            except mysql.connector.Error as error: # on gère les erreurs
                print("Error connecting to MySQL:", error)
                return "Error connecting to MySQL"

    # un renvoie par défaut
    return render_template('index.html', phrase_originale=[], trad_auto=[], trad_hum=[])

# un chemin pour le diagramme
@app.route('/plot', methods=['GET', 'POST'])
def plot():
    if request.method == 'POST':
        # permet d'obtenir le nombre de champs
        table_names = ['phrase_originale', 'trad_auto', 'trad_hum']
        column_counts = []

        for table in table_names:
            cursor.execute(f"SHOW COLUMNS FROM {table}")
            columns = cursor.fetchall()
            column_counts.append(len(columns))

        # on ferme curseur et connexion
        cursor.close()
        db.close()

        # on construit un diagramme qui compare le nombre de colonnes pour chaque table
        plt.figure(figsize=(8, 6))
        plt.bar(table_names, column_counts, color='skyblue')
        plt.xlabel('Tables')
        plt.ylabel('Nombre de champs')
        plt.title('Nombre of champ par table')
        plt.ylim(0, max(column_counts) + 1) 
        plt.tight_layout()

        # on sauvegarde en bytes
        img_bytes = io.BytesIO()
        plt.savefig(img_bytes, format='png')
        img_bytes.seek(0)

        # on encode les bytes en base64 pour html
        plot_encoded = base64.b64encode(img_bytes.getvalue()).decode()

        # on renvoie le template html
        return render_template('matplotlib.html', plot=plot_encoded)

    return render_template('matplotlib.html', plot=None)            

# permet de lancer le serveur
if __name__ == '__main__':
    app.run(debug=True)