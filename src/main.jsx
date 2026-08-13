import React from 'react';
import { createRoot } from 'react-dom/client';
import { Lock, Globe2, ShoppingBag, ShieldCheck, Users, FileText } from 'lucide-react';
import './style.css';

const ids = {
  client: 'CLI-000001',
  site: 'SIT-000001',
  azure: 'dse-sit-000001-public',
  repo: 'ecosysteme-demainsite'
};

const produits = [
  { slug:'modele-site-vitrine', titre:'Modele site vitrine', desc:'Base de site public connectable a SharePoint.', prix:'Sur devis' },
  { slug:'pack-affiche-client', titre:'Pack affiche client', desc:'Creation support visuel client avec tracabilite.', prix:'Sur devis' },
  { slug:'media-demainsite-universal', titre:'Media DemainSite Universal', desc:'Catalogue de produits numeriques et contenus.', prix:'Bientot' }
];

const clients = [
  { code:'CLI-000002', site:'SIT-000002', nom:"Acti'Dem", desc:'Site client pilote a recreer depuis la structure officielle.' },
  { code:'CLI-000003', site:'SIT-000003', nom:'Carottagexpert', desc:'Site client pilote a recreer depuis la structure officielle.' }
];

function App(){
  return <div className="app">
    <header className="topbar">
      <div className="logo"><strong>DS</strong><span>DemainSite Ecosysteme</span></div>
      <nav>
        <a href="#services">Services</a>
        <a href="#produits">Produits</a>
        <a href="#clients">Clients</a>
        <a href="#architecture">Architecture</a>
        <a className="login" href="/.auth/login/aad">Connexion</a>
      </nav>
    </header>
    <main>
      <section className="hero">
        <p className="badge">{ids.client} · {ids.site} · {ids.azure}</p>
        <h1>Le centre de votre univers numerique</h1>
        <p>Site public officiel DemainSite. Les visiteurs consultent le catalogue. Les achats, espaces clients et documents passent par connexion et droits SharePoint.</p>
        <div className="heroActions"><a href="#produits">Voir les produits</a><a className="secondary" href="#architecture">Voir l'architecture</a></div>
      </section>
      <section id="services" className="section"><h2>Services</h2><div className="grid">
        <Card icon={<Globe2/>} title="Site public" text="Pages publiques, articles et catalogue visibles sans connexion."/>
        <Card icon={<Lock/>} title="Espace prive" text="Power Pages pour proprietaires et utilisateurs autorises."/>
        <Card icon={<ShieldCheck/>} title="Droits par site" text="Chaque utilisateur voit uniquement ses sites autorises."/>
      </div></section>
      <section id="produits" className="section alt"><h2>Catalogue public</h2><p>Consultation publique. Achat et telechargement uniquement apres connexion.</p><div className="grid">{produits.map(p=><Product key={p.slug} p={p}/>)}</div></section>
      <section id="clients" className="section"><h2>Sites clients pilotes</h2><div className="grid">{clients.map(c=><Client key={c.site} c={c}/>)}</div></section>
      <section id="architecture" className="section alt"><h2>Architecture officielle</h2><div className="timeline">
        <Step title="SharePoint" text="Source officielle metier : clients, sites, produits, articles, droits."/>
        <Step title="GitHub" text="Depot de structure : ecosysteme-demainsite."/>
        <Step title="Azure Static Web Apps" text="Publication publique : dse-sit-000001-public."/>
        <Step title="Power Pages" text="Espace prive connecte pour proprietaires et personnes autorisees."/>
      </div></section>
    </main>
    <footer>Pascal ZIMMER · DemainSite · PascLaure · Blogs-Site</footer>
  </div>
}
function Card({icon,title,text}){return <article className="card"><div className="icon">{icon}</div><h3>{title}</h3><p>{text}</p></article>}
function Product({p}){return <article className="card"><ShoppingBag className="small"/><h3>{p.titre}</h3><p>{p.desc}</p><strong>{p.prix}</strong><br/><a href={`/#produit-${p.slug}`}>Voir la fiche</a></article>}
function Client({c}){return <article className="card"><Users className="small"/><h3>{c.nom}</h3><p>{c.code} · {c.site}</p><p>{c.desc}</p></article>}
function Step({title,text}){return <div className="step"><FileText/><div><h3>{title}</h3><p>{text}</p></div></div>}

createRoot(document.getElementById('root')).render(<App/>);
