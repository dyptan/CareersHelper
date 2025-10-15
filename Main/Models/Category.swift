//
//  Category.swift
//  CareersApp
//
//  Created by Admin on 10/12/25.
//  Copyright © 2025 Apple. All rights reserved.
//


enum Category: String, CaseIterable, Identifiable, Codable {
    case engineering = "Engineering"
    case arts = "Arts"
    case publicServices = "Public Services"
    case sports = "Sports"
    case health = "Health"
    case technology = "Technology"
    case education = "Education"
    case outdoors = "Nature"
    case design = "Design"
    case language = "Language"
    case media = "Media"
    case tourism = "Tourism"
    case law = "Law"
    case business = "Business"
    case construction = "Construction"
    case automotive = "Automotive"
    case aviation = "Aviation"
    case maritime = "Maritime"
    case logistics = "Logistics"
    case retail = "Retail"
    case science = "Science"
    case humanities = "Humanities"
    case hospitality = "Hospitality"
    case fashion = "Fashion"
    case service = "Service"

    var id: String { rawValue }

    static func icon(for category: Category) -> String {
        switch category {
        case .engineering: return "🧰"
        case .technology: return "💻"
        case .arts: return "🎭"
        case .publicServices: return "🛟"
        case .sports: return "🏆"
        case .health: return "🩺"
        case .education: return "📚"
        case .outdoors: return "🌲"

        // New categories
        case .design: return "🖌️"
        case .language: return "🗣️"
        case .media: return "🎬"
        case .tourism: return "🧳"
        case .law: return "⚖️"
        case .business: return "💼"
        case .construction: return "🏗️"
        case .automotive: return "🚗"
        case .aviation: return "✈️"
        case .maritime: return "🛳️"
        case .logistics: return "📦"
        case .retail: return "🛒"
        case .science: return "🔬"
        case .humanities: return "🏛️"
        case .hospitality: return "🍽️"
        case .fashion: return "👗"
        case .service: return "🛍️"
        }
    }

    var persona: Interest {
        switch self {
        case .publicServices, .education, .health, .service:
            return .people
        case .engineering, .technology:
            return .tools
        case .arts:
            return .creative
        case .outdoors:
            return .outdoors
        case .sports:
            return .sports

        // New mappings
        case .design:
            return .creative
        case .language:
            return .people
        case .media:
            return .creative
        case .tourism:
            return .people
        case .law:
            return .people
        case .business:
            return .people
        case .construction:
            return .tools
        case .automotive:
            return .tools
        case .aviation:
            return .tools
        case .maritime:
            return .outdoors
        case .logistics:
            return .tools
        case .retail:
            return .people
        case .science:
            return .science
        case .humanities:
            return .people
        case .hospitality:
            return .people
        case .fashion:
            return .creative
        }
    }

    var description: String {
        switch self {
        case .publicServices:
            return "Helping your town and country! This can be government, police, firefighters, mail carriers, and more."
        case .education:
            return "Teaching and learning with students, making school fun and helping minds grow."
        case .health:
            return "Keeping people healthy and safe: doctors, nurses, dentists, and helpers at clinics and hospitals."
        case .engineering:
            return "Designing and building things like bridges, machines, and robots. Lots of problem solving!"
        case .technology:
            return "Making apps, games, and computers work. Code, test, and create cool digital tools."
        case .arts:
            return "Drawing, music, dance, cooking, and creating beautiful things that make people smile."
        case .sports:
            return "Playing and coaching sports, staying active, and working as a team to reach goals."
        case .outdoors:
            return "Caring for parks, animals, and our planet. Work outside and protect nature."

        // New descriptions
        case .design:
            return "Make things look great and work well—like logos, apps, clothes, and rooms."
        case .language:
            return "Use words to connect people: translate, teach languages, write, and communicate."
        case .media:
            return "Create videos, podcasts, news, and social posts that inform and entertain."
        case .tourism:
            return "Help people explore new places: plan trips, guide tours, and make travel fun."
        case .law:
            return "Protect rights and follow rules: lawyers, judges, and helpers who know the law."
        case .business:
            return "Start and run companies, manage money, sell products, and help teams succeed."
        case .construction:
            return "Build homes, roads, and cities with tools, machines, and teamwork."
        case .automotive:
            return "Work with cars and trucks: design, fix, and test vehicles."
        case .aviation:
            return "Fly and care for airplanes: pilots, mechanics, and air traffic helpers."
        case .maritime:
            return "Work on or near the sea: ships, ports, rescue, and caring for oceans."
        case .logistics:
            return "Move things where they need to go: plan routes, track packages, and manage warehouses."
        case .retail:
            return "Help customers find what they need in stores and online."
        case .science:
            return "Discover how the world works: labs, experiments, and new inventions."
        case .humanities:
            return "Study people, history, and culture to understand our world better."
        case .hospitality:
            return "Welcome guests in hotels, restaurants, and events to make their day great."
        case .fashion:
            return "Create clothing and styles, follow trends, and help people express themselves."
            
        case .service:
            return "General service work: babysitting, cleaning, and doing errands."
        }
    }

    var examples: String {
        switch self {
        case .publicServices:
            return "Government, military, police, firefighters, mail carriers"
        case .education:
            return "Teacher, librarian, tutor, school counselor"
        case .health:
            return "Doctor, nurse, dentist, paramedic, therapist"
        case .engineering:
            return "Civil, mechanical, electrical, robotics"
        case .technology:
            return "Developer, tester, security, data"
        case .arts:
            return "Artist, musician, chef, designer, actor"
        case .sports:
            return "Athlete, coach, trainer, referee"
        case .outdoors:
            return "Park ranger, gardener, marine biologist"

        // New examples
        case .design:
            return "Graphic, UI/UX, fashion, interior"
        case .language:
            return "Translator, interpreter, language teacher"
        case .media:
            return "Journalist, videographer, editor, social media"
        case .tourism:
            return "Tour guide, travel agent, event planner"
        case .law:
            return "Lawyer, paralegal, judge, legal assistant"
        case .business:
            return "Manager, marketer, accountant, entrepreneur"
        case .construction:
            return "Carpenter, electrician, plumber, site manager"
        case .automotive:
            return "Mechanic, auto designer, test driver"
        case .aviation:
            return "Pilot, flight attendant, aircraft mechanic"
        case .maritime:
            return "Sailor, marine engineer, coast guard"
        case .logistics:
            return "Dispatcher, supply chain, warehouse manager"
        case .retail:
            return "Sales associate, merchandiser, store manager"
        case .science:
            return "Biologist, chemist, physicist, researcher"
        case .humanities:
            return "Historian, anthropologist, philosopher"
        case .hospitality:
            return "Hotel staff, chef, server, concierge"
        case .fashion:
            return "Fashion designer, stylist, tailor, merchandiser"
            
        case .service:
            return "Dog sitter, pet groomer, personal trainer"
        }
    }
}
