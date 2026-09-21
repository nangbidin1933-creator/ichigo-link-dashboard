# Ichigo Link Dashboard

Dashboard privat untuk menyimpan banyak link CBT menggunakan Next.js + Supabase + Vercel.

## 1. Supabase
1. Buat/open project Supabase.
2. Authentication > Users > Add user: buat email + password admin.
3. SQL Editor > jalankan `supabase/schema.sql`.
4. Salin UUID user admin dari Authentication > Users.
5. Jalankan `insert into public.admin_users(user_id) values ('UUID_USER_ADMIN');`.
6. Project Settings > API: salin Project URL dan anon/public key.

## 2. Local
```bash
npm install
cp .env.example .env.local
```
Isi:
- NEXT_PUBLIC_SUPABASE_URL
- NEXT_PUBLIC_SUPABASE_ANON_KEY

Lalu:
```bash
npm run dev
```

## 3. Vercel
Upload repository ke GitHub, lalu import ke Vercel.
Environment Variables:
- NEXT_PUBLIC_SUPABASE_URL
- NEXT_PUBLIC_SUPABASE_ANON_KEY

Tambahkan untuk Production, Preview, dan Development jika diperlukan. Deploy.

## 4. Keamanan
Jangan masukkan service_role key ke frontend atau `NEXT_PUBLIC_*`. RLS membatasi tabel sehingga hanya user yang terdaftar di `admin_users` dapat mengelola link.
