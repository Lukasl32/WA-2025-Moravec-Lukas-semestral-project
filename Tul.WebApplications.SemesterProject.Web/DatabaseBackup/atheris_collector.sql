-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Počítač: localhost:3306
-- Vytvořeno: Stř 04. čen 2025, 21:30
-- Verze serveru: 10.11.11-MariaDB-0+deb12u1
-- Verze PHP: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `atheris_collector`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `collections`
--

CREATE TABLE `collections` (
  `id` uuid NOT NULL,
  `user_id` uuid NOT NULL,
  `title` varchar(64) NOT NULL,
  `description` text DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `collections`
--

INSERT INTO `collections` (`id`, `user_id`, `title`, `description`, `created`) VALUES
('34e97c5a-adbd-445a-a76e-665dd4c519ca', 'bf63ff08-90a0-4953-b392-accb952d06af', '2525', 'sd', '2025-06-04 10:26:00'),
('9dca1401-bb98-4afa-b984-9c0e52ecf15e', 'bf63ff08-90a0-4953-b392-accb952d06af', 'God\'s collectio2', 'asd', '2025-06-04 10:15:06'),
('e6adde11-2951-41e5-8b95-b7cd99fa8e17', 'bf63ff08-90a0-4953-b392-accb952d06af', '25252', '51561', '2025-06-04 10:39:54'),
('6a3d3442-3fea-11f0-8cd5-d208b05ab372', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', 'Výlet na skalní hordu', NULL, '2025-06-02 21:55:42'),
('e6ee00c6-21aa-42ea-a41b-e98f58419e43', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', 'God\'s collection', '526', '2025-06-04 09:48:57');

-- --------------------------------------------------------

--
-- Struktura tabulky `pictures`
--

CREATE TABLE `pictures` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `collection_id` uuid NOT NULL,
  `fileName` varchar(128) NOT NULL,
  `path` text NOT NULL DEFAULT '/',
  `created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `pictures`
--

INSERT INTO `pictures` (`id`, `collection_id`, `fileName`, `path`, `created`) VALUES
('8c426871-3ff1-11f0-8cd5-d208b05ab372', '6a3d3442-3fea-11f0-8cd5-d208b05ab372', 'fotkač1', '/', '2025-06-02 22:46:46'),
('8c426b5a-3ff1-11f0-8cd5-d208b05ab372', '6a3d3442-3fea-11f0-8cd5-d208b05ab372', 'fotkač2', '/', '2025-06-02 22:46:46'),
('8c426c1b-3ff1-11f0-8cd5-d208b05ab372', '6a3d3442-3fea-11f0-8cd5-d208b05ab372', 'fotkač3', '/', '2025-06-02 22:46:46'),
('8c426c79-3ff1-11f0-8cd5-d208b05ab372', '6a3d3442-3fea-11f0-8cd5-d208b05ab372', 'fotkač4', '/', '2025-06-02 22:46:46'),
('8c426cc6-3ff1-11f0-8cd5-d208b05ab372', '6a3d3442-3fea-11f0-8cd5-d208b05ab372', 'fotkač5', '/', '2025-06-02 22:46:46');

-- --------------------------------------------------------

--
-- Struktura tabulky `tokens`
--

CREATE TABLE `tokens` (
  `id` uuid NOT NULL,
  `hash` varchar(256) NOT NULL,
  `user_id` uuid NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `tokens`
--

INSERT INTO `tokens` (`id`, `hash`, `user_id`, `created`) VALUES
('3c393c17-6802-42dc-9090-0276ae7ea1b2', 'b6X-f0v0o1jjpo_2fACnycrWqweEiyVAMEmH7SnCM5yROXadT3zfixrjkUAHn3osOu-f6nhstGJmZ6Eg_cJEnImqbj6AKpZPpfUxq-3geEIJFrhwoNWpyusSm1u4BYUp5I8y0pAAAVdIEIlAFKnyTUO6Z6Z1MpsSQ7uIULEK-LbOqMXHS2d8Do2h8wDI97o8AHe_0gAOURd7LOoNqE1Yc3xQ5iAVw5qSuGxxyXiv3I91AYdhnX5si2bcDQYWDs00', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 10:27:12'),
('b161878f-8ce4-4679-a738-039cd63eb124', 'YR8uZGMGn5IArxy8kZFeE0CTMUzGvAc6ZWuEI7N9fmfOtCjCvl4ERFlcPNjy_Y35lkOrWWX_BNLjSJ6t-SpEWgnFAfnp8vbDOSNg6OJ92CZBnxwieaIftpyl5eMF9W22NDnUGhkS2UFNZaXGovTTRcugXJbYVeiLKew0yvS7cG6vBtO_F-_1jmjIYq_vJEYTlnM8DRpf37Ilry5TWHU1WAhm9cN-CiEfzrTlBrdTwbcQb80vAgZWhHuz3rHfye79', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 11:07:46'),
('ae559233-1427-48fb-a182-06b9b9595471', 'I5_3SY_OkMKKMUCLui4Hv6BF_aYmqzqoOQN3J_YyQelXsZ0T8NgLM7IzKrtpT48Y2gfmBqvY0EB_-oeMSvnusoeEtGuWyYeb-2_orlMV8xqgrRD95QmPoiqOwZjaFZfWsjdG2OCt0IMfYNXxf1k5eMlEbT1kx1cIvvBZvTkjA13huDQXSwcsrVyhXEfXudgsBsh071HFZiuSV2QWLKhFn0XBBwlGFm90-uGYYFYTKseiGctdTskzkI9jiLOGcVxy', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 22:17:09'),
('d308ca3f-8456-4a38-a043-0c95d32d856c', 'VQbCov_5rMKdPvsMivdnT6UL5MKNQTbC1s3HInvkHbBH0evwNZnAF1NQr5tKmG-DHosSKkQDF5Am6I2-OvEFzyjf3uFuCvtIDjKgB8d6oOI8V-AysTvSfz4wLnDXMeDSG991AvCKs8_nx4GMoCkJoeEsqUro8FwFbF-bLHX3Zrgw3OQnpT0w0ErvdBXAEeO0e0fk1eH8GPKN4p_fWjfw4_PJYZWAxqayR_ymSwwaYsyH2CCUOADJXov8mChepE2k', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 22:43:09'),
('10ad88cb-4f45-4701-bb4d-0f6d810251b1', 'aYGZx1vdPRRqJ7yDfTaDOLa9wKAwuqIt_GPOoaFhr1dSKBTBWd-ic95Mq06LKtb1tULNygOIRx_pno7t_fLfyd7J2GzYB8XeWdCGeww6rqFVVgL45ScrKIOQeneqGcbKfVMTO75VuKV-uQXcnE6j4-0yqqhYoNENeQ7-mE5iy0XEupkxkdD1A1U5i8kvIjgxsc6ZaxaSY_sBDNeNbS-BLgzxt28fr3t_Nz7AU-BgHktXQcpAXLK-7JG9gU4iqdiF', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 10:27:58'),
('69dc39b1-358e-425b-9b50-0fe0094439fa', 'STR7C-3XzK_bdOzsb2hh2feyd71Lqdu8NQA3eD0Yy2dvcI38kEqoGlGc8UnsFCYdqLijktPjkuM1oC7WLW9OSi585owFwUsx2LysysdtT4JMqufYIUtwRw98G7oVle9ijJTQ8_9tVgn5iS7OndC2HEzzV8NCUSuKL-QPuRjfiyLiPGHoQtAqxQxO31xcGfBoGU_yOUROED5BxBNhVmqPIhD5Kn5wrxSIOklIFYJrWzqI8_95Dz_-WUGnrZ4YdAw5', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 21:52:12'),
('ace618de-3b8f-4e4e-9647-13ba52729b34', 'kfjOPEU_NELYRLeyzU0z11Lj9c7U90y5Dm9UluE4cqGlpPBc2ZjfDX3Mexw5Yh2WbDMO6xXivNzYMoSHRZ2nsqtyAvVAWdhd29LR2G_SZCjUxyEAWvoH2IYAXdf6EMD1f5yV1S5n883aj5_qhFOtHDnjnRe_9NmX4VFGic_IrWuZFRCanofWOxcpvVKO0HQvs4C-mQZlR-44Jd5QWHyTXZw4cITDNFNi6sgtxsmuUxWdk7nULBSdq0ZPw_gIziiw', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 21:53:51'),
('71449c24-d974-47d0-8529-1b49a5af9198', '4czlVcLMsm4wlgnsCntP98qNQynpCvJLiOCRfn7hYBxvxhe4prfWuc9ROGnc0D3Fy0vJSAY1ZLtJnML_IXS96aKhZws3IXSHCbuqC27NSH9zcCS4C6oRjnzmlj7BZ8EngtFm14x_57DdWZtYf3VCAIfkhqBDvYyu7Jpvm1lgAbTk8JrP85lXkMsxzeD5uVgvOuh73C4GUMP-1D9tWcTS3E2o257mbyIfEE5Bk11CQPn1hXR_fM2pa4ppvvGzCJGA', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 13:25:55'),
('14ac421c-0de0-42f5-b273-277d280eb8a9', 'kzQVK6FuYazXkJJtJvV5QTFhdXiRA0AH7q2mQgkQrEXMRFRKXlCAoDR1vbqzLTvRxRnK5xpcdh07r4hm75HAG_dQmZjQD24LJY1SFH0kcXkp5sCMJIhsmxcxcHMPBNSfh4CxqV3c4jTbZ41UNEiH7rg2CJ7b4lxvk6hKr86kzXdFw51QQtdMxeZEofXH8qY-w68I7T9Gn1RiWag0FUoKtaU_VQ8gRmDt1WmdVZCcMSS16VZqsMoMaILchaLuM-Ix', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 23:37:06'),
('db292a6e-2db0-4640-83d2-2c12621c015e', '24w2E7jnftX2wRbaIg5grRJfezlgVQXtvo-fNOtXIFtSYkFfWVggpuKXpq4mTBqylP_2ZuMMIoNWbDODM3aVs3ShD8NJcUJpx_oaeVF8MC4QE05YaHzvPi8Lv06xk1LW7vKjXx7jI68I2r9VaxnIvkR_EqyiVhf4VZ3Gf5PFcPT9-reRbS-ol7RA6l_JEK1xLUaKVdvDbrGtl7-i1u2mCEE5O0u2QDSlknznqoNYwAwgsEd94P3AvO_5Lqyynq8c', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-04 09:48:18'),
('4be80700-4877-49b1-8d06-2d7b0427d986', '6e_vZqA06Hd7t1jAC7XPWmQX0vY8F9nsec0uXZ90BY5xS5cYJqG9M3eS2R1zPMZ2GsPb7x9eyaOiot3fUi4FpOMFpt7Ty5T4YcjCNG3-yGfSb5NoooKJIwc5-ztzKUpSUFpKzRaFG40978VzHwPeHPa-704k3_C7kTFvgbzWWuqfaM4lQI0T-9W9BD9g3BYORzgErNRaka9Sytq9LdDJcplzATFdVG5OWqKHcZdvGjQABji33_4q0daH5HgTzRB3', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 22:56:01'),
('46c83373-7062-42e8-9432-2edcaea71f9e', 'iuXeithvrUbOWx39HrqnWXQiwlCA5ESyZp54_C5KFaNIztJR4rFnKjUbtSkaO_jan_wzJeR4BNgVVTbdyBkRyYkS3PCsbVdRPvjn7Kn4LRknzKmiGxH13DP2nxtjJLxKvusf2UkRPt7qO_yAF6rCmuBTLv0qyNWsMp6-nrLZRRS84oSRWHyVZPrYlF-JZJ_8QQe80LbsWx8DBWDW5aJyGIAY3Z6XL8loio2gqMT6jUsjGbOi43wGIc-nZ2lcgvPF', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 10:27:39'),
('3c69a930-576f-4cd6-b4d3-30ca53482b34', 'sXd2teQTEh2ZQISeGoYlxhyyP3WuaPKH5nx2nXw-AI0uO4ioHqvL2OYDiGdr4xAXes9l7Y7E2s6xaYpfNSGv4YdVBuffQv1UOAii2baNI4VKXU3sFd-Ci8z-e2d98tN81-bUHFjLvrfOpo-0a86PURrc685G9KDPgsiVhSZzoZkpl4c628uZ2h4Y69rKSwPeWfaEJwdjvYjLJpq0rHWzCcv7CgrkvPPxaD9IRFeT_FD_OTHJWvSNSTFyW6JmXQDf', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-03 14:37:05'),
('a987d4cd-4f49-43c7-9da4-3bc9e14e35ac', '3lhbR1viHB6Ekgy4c2tyyoK4xCL7zU5VhPKUpK6zsKfkKOCPnypvHi07KGyqN7KBTgHZ6APKSKHYKtO4ijggHFvo__DvbVbGhcOXYtV-8Dg6rRELzHsINQ_XZUvmXt_j3qeyrqs2rvhH10gl8Ycr0X8Ad4gwMHnXTFLO80OnShMq14UoX9Mcey01QlDsYZ0regZKu8mJV47rUrm509FXP8GO0XjkCgsSAuHqdt0mqvq2zJFG8PVOE6XUfFHl1TLz', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 10:35:24'),
('5ac4cadb-aa98-42d5-85f8-3f11e02f7b5f', 'WWnJvmBzpTFiqDbUAjfTaGcnHNNb-3wz6vonAa5YWZfhBMWl-T7SL0k4XQiypmgIjsgRm0T0TTsZrXGZWbJFw3Z5OPuJTmBQdB1AR3ZNJxbRVAweVLE8_MVKDN4yHFoQ5HeQr9oD6SFeCM6W0sbWln1rny2WnIeKpJW7zmU8IXMMWCIJgRk19k7cSC2RqIsBDSQtYu2aRlXQ58c1E8_rlbV588GEdCGN9DgLApnrOc7REFNlCewN8Zh2tM8FyeoR', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 14:49:42'),
('eae742e4-b670-4bc1-a082-463249a7045a', '79P5iQQ7ddAx4MZ40Q7ctjrj5VBPCKVjL0Z1Y_0Gt1KH2t5RqJsTb-Laox9zkUmpwxdTMQMJ0sXlQScwUcKWp2c7P2cabQw8Is7PohGPhXHzqSgRB46MQcKUXXA5PY95i4nEZwWqhN_KKts4EECNSBhwEyWFVXuW6nhzHeTc1EuhjElYHCI8RrMkDL8sqSfN0GeEK14V_c-aY2PmJbu3F25hl_iLMhR2JxRiAIxT4__oe1Xeuinavel0Ne8mvpB1', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 13:22:50'),
('8d49ce57-550a-48f2-af9a-494b8f565a70', 'MumZKadExZOafexVEhp1OZbgNRTkE0f5ZPRUNrtNw4INHOVlJydY36fUzNMTwnNWpYGTx3IoG0J9PC1GLbc4TKxN6JAnQOVF2c0YMtoCu9uMlUHR9bFThAnbDm097P20wZlYycJ6XkSYmNTdQhAhOrhCWXgKgDOUFSvDiafgaqqErNhC-cwAF5F8zGfyw5StzJBDft0pU0VjxJ6ZYZF1J4mDVLY1HP2vKfxGORZWvnB6lvQocA0Qx7mByXl6jA81', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 11:08:57'),
('5f5cd438-e2c0-42d8-840a-51f50a214aa0', '0GZavh36677RERkGiiTDvQaoUqbQv8acrCQED9bdGS0bZXFsbb1DR6jYR8DzG1t6dWOaDj-AifEW9nLXKojxitpebvGvZ-MO36o6Vq-dpagKQ22ryeXFj8e4sVMGynJ-72n2zn-qUiaezV8f-SQu5kZc9UdNmuEpL1IXA7VYo66eEF-wvXa4np-kJCUJnsFzyB1ia2r6-henzzEpg_XXspa2vBqZjZ3f9hpbXqKvNX9kVdTxuJll4Rsb176TGx7r', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 14:53:12'),
('6b5c440a-ddff-401b-ac58-5d8d781b1081', '1M73PtNf6LsSyWFsvqnT3ApcJ8yVfrgEK6HQLvA02n_FoRVV2OjRXbuCOGpru2CKKBesL6LTz7PEnEF4YeK9YZBiTFNzrCiFogRe1wgSS4O06shKFofc3gI3R7OydVmtc7sO36qtf7DSvR3lnHLIG868cXROikQoezv8wSErzaGZFl9YoTJ6LNGE-NHCn4iX7uBunR1-MfXVjoTw_Qx9bNC4VhKM8Ivbx-t_gvBoCLPOSTlXbJRce1golWdiN8EL', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 23:26:34'),
('06345462-b035-4928-ae78-5e64facf885e', 'Nv6Aqk0hAXYaOSiuuKvwMEq8ET4obUJtc59DXOzod88o3dCiIOx9PlHH09McrQ_ehiIxOW8nTea9gCmhGcrHiIFw6LVJgkN1jRi-hToza5HG5ios6uMx9PIBbBnRQKcArOjEVyi2MehK63Wx1g-DWBSyHbV_ZJ2NJkeNdzupLHvbnxmCyzbuXkoY4kqHCdQC_ZyQNd_2d789sGdCZ6v6Fl_XFoXbkKurVnXn10VFZR9vyLoYHsgWE2Ro0Auw6Aee', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-03 14:53:28'),
('a6778235-e116-4ca9-afb2-5e6730b30d8f', 'Sxb9wHdgbPEhtfnBmc4IQ5xW6pcYWjYAo-IcylpQbhIz7PPvjnnjZOhjQtwImqQ7AvtX10ydxBaCQ0HqmrJpPuLM4ZzHi9HVnv37kgb4mFugqZQA50tNbj5gRk0-1YwhYXlY8PwamjZe12Bl5qxHxQEiw7uqfcfPDL7tzUgAQLVTu4NpDxkfRyU1d1LCAf2BKA5aOv5Prk8eKpdwLfHalpK5djRQx5MtfDcEwjPqp9iDnxZJZ4vCym8u49WZL4EU', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 22:10:07'),
('43a29632-5d5b-464f-b80e-608d22623a95', 'mmyHwjZzUtC3Sd5QdUl-rMMUunnO37MnVGPdez6h9Fsq7wt4m7hnSjp-oRo5zlwutNVjHJ98mCnCj0XCsbR5Y08ns0E8OV2g-zktntdwQFvmETjMEiC58qJ_1aV1LDv9qGWSCMg3X1OG-et1_MBMgw4nDIkNKymZo7SwnUaY5L_BgYu1jjLK9WLDkYVt6d8oq-cZSV5ViHuhML3RqjgcIlgJw-ANbEKUEFpFaHgyMuoP58vMR3QSqUjniFCIrhAq', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 22:15:49'),
('cfa40e3d-db1e-4308-a046-67731d5d2eab', 'ablW2GvAvTpWWamzDNSDHBd0fQVBpCZYNPvObg1rIz5KcFLDeY8Nv9xlsMUhdiXgEelyOXhAYblrJIdutizjQfict9hujL5ZkbIlVVEQvw3wMBI3EPHXY6u0lmA1kWokUcfeybIq7kBibjDEocRyWyNfE8kncrmVolwJ3x4PGeDtN_GcBqa-z7UJizV8TIgjaHGPeFXPxr_EL_T0XYN9absr8UhL_n9stId9-Yq3t-AemgKr1QQrP9ZGZR5FhRV9', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 10:14:36'),
('30fab367-3153-4bed-8de2-6ac6f617bdc6', 'o-ilP97kTqB0-lpB50a5mBmODjzGswyXwTZgfzIm88iLd04M8r7UN5TdjIiylp3tRanZozfPsi4XD-_NTJTBY3ufsYqYvWapYMZLQ1hb8et7a5oWue_RWWe36Xr0aOXtcZcETj4eBv2s2vFhEe8h1TVYNCITmgBq2u3fB9kClZWseGmaQ-_ShPz1Aj3W_TLaFYgu26Kw-ztIbQPoQ-lUMSVAP1eocwPM2oUJQXSE3Tzkyl87v6NuV026XYq0X6Jf', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-04 09:09:05'),
('7ef71701-8076-4445-9606-77d07fd3e1a0', 'w0aS01_C6-k7kY7LgPki6STJPGNJ-KyiJEZoRLN88TIbiqKaT8gPz0uzHFq396TdqZ8kjuc4x8aTwHw7NclC0p9bg1Oy5CheOHQVCL4sLw-rFxgPr_ZkwC1GcUaA_FPbN2IKMRc6PGFOgC6nJnN-4C8wyXHkQo7Kb5s99dJwGsExZUAi08gjQ3GIP45G461Qb_fuV1hfd8e99oLGWnvtJ6_Bz74Ij17UzLbeafKVkSdzBBb3JlcfZos740MNbZIe', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 22:13:20'),
('f267a2b4-ab4e-4186-995c-7bd9678ff3b2', '35QEs5Nhk9n-YJUQ1hKuW0us10bkiBJID0oGfOYqmsYq132KF0oKburn-6WaosYleesBuTnbmtPQ1I8fZgLoJca39nMWA4zMAiD6HsalVikGWg2DLkRA6aEH7ZxzrhFotupIf1Xro6ys4rKlXMAar3mJIOKcuaVC-VGlSQ1vKoR-0J4riY1hv49C1Qp4W_6Jz3DeOKMM9roYyM8bhckikD8g_dWI4-OCU2LqBPqZ2ROwHXVyiVYwPKO5Z6zPFs7N', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 23:22:29'),
('4f14fc04-7353-41ae-bd54-7fde24b8f5b4', 'ZRXsUro9RoMAyBcoLhmx86ZUYLHBF9rajbg0c9_pN6_ZxHBnS2aa2jVooshKvliIvMUXstbzHkd65g6ReDsVHQjfxgaQ741wXy5aOMzVOjq2-dKs6YNtp7XrMu0RYxPuBMt8NQ2tbpiMsFKoNniBSTofw6zJZUXCm_vzabE5_7qX-bwy5SlOdLX9SMp0qwiTArVFj63thLRbdiHe7WivRvdxUyAzSNlyF5gOKX5IVQ92noHFa1UwXY3uKlVFVAvz', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 23:31:27'),
('41afdab2-620a-4d11-a11d-828320ac68b8', 'z4BeIuhh1C_V7E8Btg2zx7c6-qYM97BMBkbEL-iHAJQjW1AHnP4oYrp5qIBccoKTcW7tGH2pAmCvRsaBXmEX9AqU92NQd9bQ_y7eytE58BSbkVvF9dZWT5OSdsSmQUT9B8156tfR-owPfJHetwvcZic6vMCDxXsPQdPmv53CGV1kDZzw-NWOJKB9kD8b4opwbwBStJ9TbfjuvjyBdbLvPCSf52CUbBfsqNEqBXWmjlpVOiASYmHYKSjxPXtKvruc', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 13:24:11'),
('775b6c85-3385-41f7-8e91-8b8521846fd8', '4aWyII-6gLMuDSIsSmtyC-B7yKa77Sr2ZQBkLkPbA60ZQ23wQjE3eSJm3qfhWVf6qhYA7PyZpNCbJegSyzofrsZsBeuMTDqK9uNQASYFqC8xPN6ZSG031O94GfUtjI6NC_0OEhGaaj8MqN-KPniMTuhgiJ0YEnfaREPNHGy6I2lQR1MPRTGGQtCpnVhmzJ7tNwoepGd_Q7fWn2C2wA31879-m8IvnkXr0qnFhWC6hG27IH-iZ_0UEi6EpSruODoi', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 23:33:46'),
('8bf35bc8-8d80-4f9c-aa24-98789734f1c3', '8D7n-m25jqEZLJb0JeuZN3aIRHZmaz3qsNQA2ZamoxrnLaB0VkzyKikRVUAqJtNM_EjrBSmBDBzj5oycob3_SQ4DMX1KyLmi-yndzvy_2g64ZcXvo87Wi_D1aL8EL2EO3kgMTrJ_WIMMTWo3ipJwzjnt-NTZ1WtvmXO0qnskc8a7K-2IHU1qQFYdHKZXSpAmI-UQN_YEmT57jwuoyCyzXEJaX6cOif73y8eKFglDrnNbLMGWp2x0chS0APTtqdnK', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 21:27:18'),
('2d028dc0-6ddf-4ee7-90f6-a9574edee68a', 'F-leAmgp0my9fsyk8xkbtoZeswgurP0YvFXTW4IAiTe_oxZm3lZ5UwVnjmJy509U5oZDgvLxexVAemD_QeQgRm7naddJ7LS5ZBZ5zHpXMCV_l_Fe2S-bFLZdb3OPIMOXa6-whmfIJRO6by073YAtXST-xoqZhCj_2-AJ2S982quOz9Tg0JSZJXj9pnKejHY7v7MSnO62EfMYHcuAmKX-UaTOBR-iGRKxo6-KMqs5pOaxKe-0tY7RcVEOLt4JQFrm', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 13:32:53'),
('30a48202-2bfe-4563-8800-ad9f77ce174a', '46IYZMy6jQ-J2-eS_EJVMC8ymW_2d9wKckaEeDfp65FxLghv6SlrobUU_Kjh12OZHaoLRurjYqgV5eBIdHcRj9kmt5NjQC8UR7WYGMz466lgeq1sL2-0m61uv-Px023WyNb3N_wPYKkwUfKmCmHN0HbUKVsIPK2tMNhzB9BAWaZa6mIz0C-Fvo3xKdtA9jItwujJdb057xQ-DNHx8ZXRfD9ghgbLK3yb62vXKU41cFXadhdmq3UA1GGVtRJLHXBt', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-04 09:40:47'),
('0d0ff821-994f-48a6-af53-af39e1561515', 'O9RPUt9oJFffxOgGiLdS2-2D1lc56YPQ4_oUJKqGxNTOyWeEuA1FZCLi3P8NrjvNCWfZcbfwNVzm3-XAaXC8pocjeQGrSERPI12boIyu0chkdY7gSY5q9F6t8DrJynMdSNmswIEHY0oPjXvU-IGR80-3U_KzVTb2QpxoWA9ez3Zn93_iLSxfTEKv-KGGXda7un7rnPLDGpp696jKzuah4GF6Yupg7qVUoVk7tKFxxO61EAiU4HjNNhXL8FMA9DTy', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-01 21:59:17'),
('b1ad8d45-a4b5-4651-a478-b0cd9b456a3d', 'ocCsIL6FLKAfw11jvX2FioojObyMsA6ZDIOSDgrPbFJgmcC6nHxsm6Zj0W7FW_rn4pSer_pO4HTFYVjVbSpFnkeoiTRAcbuVt99g1nhOf_35aCNABDA90G8QfarpK76c5hBsYUuimxJBHgIPkAe0YE9XZXpNCwuhcYleHy1TqN_LUhYUTqojvUWI1Ybv5f8meIhEBHdmLqRjwPQl4-QyMtSQCqFtd4YRJ3b025NAN88Z2_2zsrXVf-VNAPL0IgL6', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 22:40:43'),
('3b19c22f-6dfd-48b7-a5e5-b2c3b3f8cd40', 'X3dbc88kNRw3bsG3goNl-R01u8rlWqyffrPOClWs1tmOABCGhHKLXFTDMTBaTjfGYgTmggoGr1EDwXCE88l0Nzs9QgUew_4AMexbJwtorY52oyd5NYbl8e9wjn7jvNIJoLDrOJC-4UTCbPtEtbhyL5GdKbo6oNByzjgSlaa8pIbnG5FnMlHZsOTYW9wv0MuPciIbbCug3q8lrKej0KT6ouPIABgERFTDyBWaomH656v1qiWmsye9sTRV-n6QPDv-', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 22:11:56'),
('9be4baea-3e42-4a8b-9ec8-b6552f2b2f8e', '4q2LXKDqn8mf_k597rW2VrGQNwSV8iG8OR3FCgxPEpOyCi2YLGsLY0ehOG69Ta0j-OhYF6-ZZ800K6u9D4JsZNhQQvO1NZ-brsWowIj6SzwnUqnGW5vqdrGUH6qRO0e6uQJMvp3DMZIhDsXE2-J595hKdADGnDr0ggUyn3gcpnpPMHtlmdvLdCpUKgE-8duhyTY8KlT3RjVNmeVMj2UAO0UGqv7mHGL7iH8pInWVbmM2L0IKSpO1JInOXEtoII67', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 10:57:26'),
('4ad89168-9a4a-4776-948c-c8356507d601', '5N0ZG48wWvlieYKjIR9Bx6ypjRvImPBnTu27P2dyBVhR_Z5lsSBmYNSAakyoxoaq6D7I9q1LXwMjhW91AeShOevBJDUCXq25KUfssl6qlVYhPEtHxuHoBTBwi2vRJk2zVJEGAWq_ciCTAKGMjJJ_o-EBeJjf0Itc6erMwZ3dNhO1bcWqfE1_KhAGtmAz0ncf_N562io_S48HBOTyEIyd68Jcgk2fNd5bnGmhHRd2xaq4goICzzQopo1tJYex9PrL', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 22:44:37'),
('87346bc6-d9aa-4c05-abd6-cc304b9a84dd', '9TFcT8X_-_1zLGusBkanVgk_rFrcozRNFfiVjE7KnPs-L0YFKqxxZqiJwe47MB1rxhoD7lLchzhF--H0Jl7DdfxV6Xsj80ClJLCekaCCbnpdR3uwZDdPDcSdjoSMGVLS-P5zkY-fNJXZEzFgQyHyRakFWqNCaopCi9I3cyLeSSB1q30aHcAcRMBv3ay1dfFv9Y2-ZjSe7F-W1srwpYap-5YTOzcg_HBMLU5oafPUenSET0--2DdGmjsYiSASAM2_', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-03 14:58:35'),
('cafbeb4f-df3e-4c82-9227-dd49f2b51513', 'lYn_pwrs7dixtbHkhUqoQV3jrYO86pH26-BtMsgN1JtggL1D9wY9dvtWg_fnCAbZwGT3S8KbEv_SZPHSa1A5AP-4QpdJ_7WulHP19HwP4V0hqkiUC5hOPfRFLi1bPcUYS7LkoU81uMG7xgAa7gxBfusgavWNgtN8HykHAf8Ol3wDKUO8ZwD5zU4vXWMvebOa1eGj_OIYqChqPewJIvZ9QSn4BTz_PjP_6zgFCEswXVhM4FncLj4gNe4C4U2U5EFM', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 23:18:26'),
('0df2c1e4-61ae-4c60-bd40-e2cb72e13673', 'KUXCn2rKKZuHYR2mxgQsC7Ulvh5UZSuyY7azE_-TXjLGYASLMx5NED6YGgFv2iriKVP-BGXzJWGHXez1u3mMJZ1e5cfBo-CqVtywHR_tsTlNkh-dQIPffy3EsCXN5VXzksyAIbYJkYkhd58OLzDaWg4ZR2aZpPhD74xc8iqP5Zz7VolED37U8d31FJxORPxSQjKJXJ0JZGTBX9lioMb6vVk4F3ybFeBjs0yf3qguJW3BcE9EfRc9yDT-1yqDY8mq', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 09:09:19'),
('0e6d089a-bf94-46ef-bd76-e6ea2373c41e', 'MRRvFUQqQfObWNHPMZiKnC826zV0DRLYOAZSggc3ZIJoIBd4Cra0afrVUqQHuAbzEZu6yCZ126YPj4--ziRUlmdv6Lo_HtsA8kt7CwJ2tpRBPGIEh8GhvLib5cFKTAQxoGtH4g3-T7LQVarqK7J9q4OipybqQp26T1KFTSlInW3BxXCEiTDNOSzV0CzIGXnPwYWJ_Dfi9Z85LSbw5upjpaXFaosAkx5kIlop1KQGLce4CmDFeWwu3DCoJmxCu2qE', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-04 09:35:49'),
('58e15cdd-b98c-4f10-ad6a-e80411f7f3e4', 'dqkQEZnScD--A5CsqxmwwYSKHB1EU_-zA5hrlzfFzKe4seTJbw8xZfbgP6H2JNxSmFmK4N9_akYzK0ZA_NcTQV_OqkMQiCa4NRuFit_TFa9qtvWOaSnLrJSQsFOcY1CuKfj_Q3R7R5EvXa4AmNTFxQqZYxL2JaV4gbJXBxTiQtRjr13Xj85wA_LFahWun2gMQeeEGMP_8TZscC1nxfyMdLSp8EPhuswuEpb4YhThmsUMunbFSVcBurNHwwG0dJf1', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-04 10:25:01'),
('33940d24-2457-41d3-b7dd-eab699caf130', '9X0vDizY8xZKHhyBvtvn1VgZ49Zt5zQva_OjLEfKPN2wZrYgpPpml6kjdxORYg1eDMLKOOSteQWYOu3wPiIb9GNl0ELQVlQ4IQUOcriwueHBFrtrrFkVPHI3vr7sYDQ_vSXbqDWJc_dImu3-JIoorhEIrBTFF3cNWMxAn-y7I2KvGO1WG6XUV5mKue-gdHscQ_W7Kfzc696iiZYDcea5vHz569YThC_5R8Q0V529hhGWuWOuqOoRFNyBkhGQtTq9', 'bf63ff08-90a0-4953-b392-accb952d06af', '2025-06-03 14:59:53'),
('4008a49f-d0c2-49eb-bab0-eb87357b7832', 'jhUyHJGWo-Xgjpkri_nc-Y4ZbZImW_rsS9jznGBPcXGm6CODDFAtVjK2iyF8PgmJlaudjE4IL9DX2U-ROn3aHi0ElqOu6XEDljoa7szIFCG68w7XujxT13VXH5-PtVgVVmg48oFM7IDy6L1OdohYr9A-P4tgPEiYOZvRA5O3_u71gjoFUguYSgL7rdJfz0_R1K4uAf9LZf_SNcUkqDyGANQaeT7FVYgSb9E4QGkIJOqZbM90HKldmAH-4_W2Mgnx', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 13:09:54'),
('360a269e-f138-41e2-8c05-f6c3a7c639b0', 'WNrZoXaeldFZja353-JtCuGvRSiYvJxOdRl1_COVn4BvHivHkCCwPKzZk7g95he-5e-L8QFnZ-kdFaMffsT0EWrYlAuchyTmKXGN7heNrJRfWguauPIrbI8sY8UhIVoxpZ5C2pyc7E5Q2q_GsS9zpOWPsdJVf3H-mEteuvGx14sh4M8PnfobTK-EOx-yPb3QtQ8gVqWGv4YCNyErFSWxh-fOMBCa3w6ZphvcduT0GN4DqDDgMakZI35OGQ6xpTu1', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-02 21:39:37'),
('8eb28937-f542-4955-b580-fb6b97ffe4f5', '8MHTV724P06XWCIANiSjBUPdWdHy7e8GdWWCeg_zjC-iV94pdqnq_nLyhWl6ZAuuDNqfXACcNFASWH0LjX-OQJAuqu66zonREIKhP4guJcPt9SxL5z0vhh5t4Ocqw-V1KifmuPArigpY0M4aEb8ZWwxHQIbbtHqABrFIs3slV7vpfSzNty-f69HZxPU7BhgDk0akrnn4NQQwbqoUr78HX5HkGVDfKLEZR1dbw_Pcenw24WQ0jnQOb788CQa30tbd', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-03 14:22:45'),
('fb7913d3-a6ca-4f9f-92c6-ff94db917d8b', 'uo6AnIOqzg9zMsAh4CUHcOsjU6SKVBth5L_Oc3U_WOF60WzBFTd1DkiHP8rvUiFVmIl8h0Ei2tTxZm8y4R5ZA-3PjxpOuYitEzdjV2NlXKbS8yU3oFVBEYJ8vaesQ6tGVx3QpLsvv7FzTkLux2x2cLujPUtqv95wu4ebuwizW7LNPeV2eGBGDfjXttJmKGuc_M1n_PcSfDlQVoozj0b2MmSPUcNJDr8Lcdfyi0N1_84GTOJd-TLAM7rPvPwwicx-', 'abd06440-7d2c-4011-aa6c-5027dc42dd3c', '2025-06-04 09:37:23');

-- --------------------------------------------------------

--
-- Struktura tabulky `users`
--

CREATE TABLE `users` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `userName` varchar(64) NOT NULL,
  `email` varchar(256) NOT NULL,
  `passwordHash` text NOT NULL,
  `role` tinyint(4) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `users`
--

INSERT INTO `users` (`id`, `userName`, `email`, `passwordHash`, `role`, `created`) VALUES
('abd06440-7d2c-4011-aa6c-5027dc42dd3c', 'Lukasl32', 'lukas.moravec@tul.cz', '$argon2id$v=19$m=65536,t=3,p=1$c/xn5mo6vAu4b6DdP3PSMw$lew4A8AzV4GHDKhpYVR85vc06zLYT0hB/HoulxoAzcY', 1, '2025-06-01 21:59:12'),
('bf63ff08-90a0-4953-b392-accb952d06af', 'Phoenix', 'lukasl32@atlas.cz', '$argon2id$v=19$m=65536,t=3,p=1$c8SLTeqbO0Gv4Vau7sPbMQ$UYh7OsDheRFvZTgbpEzQCc97tWv2e/X7wEMiOGt1bd8', 2, '2025-06-03 14:37:02');

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `collections`
--
ALTER TABLE `collections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `relation_user_collection` (`user_id`);

--
-- Indexy pro tabulku `pictures`
--
ALTER TABLE `pictures`
  ADD KEY `collection_id_rel` (`collection_id`);

--
-- Indexy pro tabulku `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hash` (`hash`),
  ADD KEY `user_token` (`user_id`);

--
-- Indexy pro tabulku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `collections`
--
ALTER TABLE `collections`
  ADD CONSTRAINT `relation_user_collection` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Omezení pro tabulku `pictures`
--
ALTER TABLE `pictures`
  ADD CONSTRAINT `collection_id_rel` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Omezení pro tabulku `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `user_token` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


GRANT USAGE ON *.* TO `WA`@`%` IDENTIFIED BY PASSWORD '*0649CB2FEF48C55FA602A047BD77F157025CE2F8';

GRANT SELECT, INSERT, UPDATE, DELETE ON `atheris\_collector`.* TO `WA`@`%`;