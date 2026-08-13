import React from 'react';
import { createRoot } from 'react-dom/client';
import './style.css';
const sites = [
  {code:'DSE', nom:'DemainSite', type:'Site principal'},
  {code:'ACTIDEM', nom:"Acti'Dem", type:'Site client'},
  {code:'CAROTTAGEXPERT', nom:'Carottagexpert', type:'Site client'}
];
const produits = [
  {slug:'modele-site-vitrine', titre:'Modele site vitrine', prix:'Sur devis'},
  {slug:'pack-affiche-client', titre:'Pack affiche client', prix:'Sur devis'},
  {slug:'catalogue-media', titre:'Catalogue Media DemainSite Universal', prix:'Bientot'}
];
function App(){
  return <div>
    <header><div className="brand">DS<br/><span>DemainSite Ecosysteme</span></div><nav><a href="#services">Services</a><a href="#produits">Produits</a><a href="#clients">Sites clients</a><a className="btn" href="/connexion">Connexion</a></nav></header>
    <main>
      <section className="hero"><h1>Le centre de votre univers numerique</h1><p>Site public DemainSite alimente par SharePoint, deploye par GitHub et Azure Static Web Apps.</p><a className="primary" href="#produits">Voir les produits</a></section>
      <section id="services"><h2>Services</h2><div className="grid"><Card t="Sites publics" d="Creation de sites connectes a SharePoint."/><Card t="Espaces prives" d="Power Pages pour proprietaires et utilisateurs autorises."/><Card t="Production IA" d="Pasc AR IA accompagne les contenus, produits et supports."/></div></section>
      <section id="produits"><h2>Catalogue produits public</h2><p>Consultation publique. Achat et telechargement uniquement apres connexion.</p><div className="grid">{produits.map(p=><Card key={p.slug} t={p.titre} d={p.prix} link={`/produit/${p.slug}`}/>)}</div></section>
      <section id="clients"><h2>Sites clients pilotes</h2><div className="grid">{sites.map(s=><Card key={s.code} t={s.nom} d={s.type}/>)}</div></section>
    </main>
    <footer>Pascal ZIMMER - DemainSite - PascLaure - Blogs-Site</footer>
  </div>
}
function Card({t,d,link}){return <article className="card"><h3>{t}</h3><p>{d}</p>{link&&<a href={link}>Voir la fiche</a>}</article>}
createRoot(document.getElementById('root')).render(<App/>);
