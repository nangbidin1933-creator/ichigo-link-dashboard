import './globals.css';
import type { Metadata } from 'next';
export const metadata: Metadata={title:'Ichigo Link Dashboard',description:'Dashboard privat untuk menyimpan link latihan Ichigo CBT'};
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="id"><body>{children}</body></html>}
