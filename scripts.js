document.addEventListener('DOMContentLoaded', function () {
    const activeButtons = new Set(); // Variabile globale per tracciare i pulsanti attivi
    
    const toggleButton = document.getElementById('toggle-navbar');
    const annotationMenu = document.getElementById('annotation-menu');
    const themeMenu = document.getElementById('theme_menu');

    toggleButton.addEventListener('click', function () {
        // Toggle espansione/contrazione
        const isExpanded = annotationMenu.classList.contains('expanded');
        annotationMenu.classList.toggle('expanded', !isExpanded);
        themeMenu.classList.toggle('expanded', !isExpanded);

        // Cambia l'orientamento della freccia
        toggleButton.classList.toggle('expanded', !isExpanded);
    });

    // Funzione generica per gestire i menu
    function handleMenu(menuId) {
        const buttons = document.querySelectorAll(`#${menuId} button`);

        buttons.forEach(button => {
            button.addEventListener('click', function () {
                const type = this.getAttribute('data-type');

                if (type) {
                    const elements = document.querySelectorAll(`.${type}`);

                    if (activeButtons.has(type)) {
                        // Disattiva
                        activeButtons.delete(type);
                        this.classList.remove('active');
                        elements.forEach(el => el.style.backgroundColor = '');
                    } else {
                        // Attiva
                        activeButtons.add(type);
                        this.classList.add('active');
                        elements.forEach(el => el.style.backgroundColor = getColorForType(type));
                    }
                }
            });
        });
    }

    // Funzione per gestire le coppie di classi
    function toggleAnnotations(classA, classB, highlightColor, toggleButtonId) {
        const toggleButton = document.getElementById(toggleButtonId);

        if (!toggleButton) {
            console.warn(`Elemento con ID '${toggleButtonId}' non trovato.`);
            return;
        }

        toggleButton.addEventListener('click', function () {
            const choices = document.querySelectorAll('.choice');

            choices.forEach(choice => {
                const elementA = choice.querySelector(`.${classA}`);
                const elementB = choice.querySelector(`.${classB}`);

                if (elementA && elementB) {
                    if (elementB.classList.contains('visible')) {
                        // Mostra il primo elemento, nascondi il secondo
                        elementB.classList.remove('visible');
                        elementA.classList.remove('hidden');
                        elementB.style.backgroundColor = '';
                    } else {
                        // Nascondi il primo elemento, mostra il secondo
                        elementB.classList.add('visible');
                        elementA.classList.add('hidden');
                        elementB.style.backgroundColor = highlightColor;
                    }
                }
            });

            // Aggiungi o rimuovi lo stato attivo per il pulsante
            if (activeButtons.has(classA)) {
                activeButtons.delete(classA);
                toggleButton.classList.remove('active');
            } else {
                activeButtons.add(classA);
                toggleButton.classList.add('active');
            }
        });
    }
    

    // Chiamate della funzione per ogni menu
    handleMenu('annotation-menu');
    handleMenu('theme_menu');

    // Chiamate della funzione per ogni coppia di classi
    toggleAnnotations('abbr', 'expan', '#00FFFF', 'toggle-abbr');
    toggleAnnotations('orig', 'reg', '#4682B4', 'toggle-orig');
    toggleAnnotations('sic', 'corr', '#1E90FF', 'toggle-sic');

    // Funzione per assegnare colori diversi a ogni tipo
    function getColorForType(type) {
        const colors = {
            person: '#FF0000',
            place: '#FF4500', 
            role: '#FFA500',  
            title: '#FFD700',  
            org: '#FFFF00C4',   
            foreign: '#7FFF00', 
            quote: '#32CD32',   
            date: '#00FF00',    
            num: '#228B22', 
            measure: '#8FBC8F',    
            verbum: '#20B2AA',  
            distinct: '#40E0D0',
            nature: 'rgb(161 34 255)',  
            infrastrutture: '#9370DB', 
            pubblica_amministrazione: '#EE82EE', 
            law: '#FF00FF',
            event: '#FF1493',     
            art: '#FF69B4',     
            education: '#DB7093', 
            math: '#FFE4B5DE',    
            verismo: '#CC3737'  
        };
        return colors[type] || '#ffffff';
    }

    // Gestione delle aree cliccabili e scroll
    document.querySelectorAll('area').forEach(area => {
        area.addEventListener('click', function(e) {
            e.preventDefault();

            const areaId = this.getAttribute('id');
            const targetId = 'pag' + areaId.substring(1);
            const targetElement = document.getElementById(targetId);

            // Log per debug
            console.log('ID cercato:', targetId);
            console.log('Elemento trovato:', targetElement);

            // Rimuovi l'evidenziazione precedente
            document.querySelectorAll('.highlight.active').forEach(el => {
                el.classList.remove('active');
            });

            // Aggiungi l'evidenziazione al nuovo elemento
            if (targetElement) {
                targetElement.classList.add('active');
                targetElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
            } else {
                console.warn('Elemento non trovato:', targetId);
            }
        });
    });

});
