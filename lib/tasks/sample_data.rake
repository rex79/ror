# -*- coding: utf-8 -*-

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Administrator",
                 email: "admin@internalconsulting.it",
                 password: "foobar",
                 password_confirmation: "foobar",
                 active: "1",
                 level: "0")
  end

  desc "Add a custom servizio for testing purpose"
  task add_servizio: :environment do
    home = Servizi.create!(nome: "home", label: "Home", enabled: "1", ordine: "1", path: "/", fkparent: "0")
    servizio = Servizi.create!(nome: "servizio", label: "Test servizio", enabled: "1", ordine: "1", path: "", fkparent: home.id)
    servizio.path = "/admin/mods?id=#{servizio.id}"
    servizio.save!
  end

  desc "Add the default languages to the db"
  task languages: :environment do
    Lingue.create!(cod: "it", lingua: "Italiano", active: "1")
  end

end

